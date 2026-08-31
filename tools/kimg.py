import sys
import os
import urllib.request

try:
    from PIL import Image
except ImportError:
    print("ERR: Pillow not installed. Please run 'pip install Pillow' on host.")
    sys.exit(1)

def render_image(image_path_or_url, max_width=60):
    try:
        if image_path_or_url.startswith("http"):
            req = urllib.request.Request(image_path_or_url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req) as response:
                import io
                img = Image.open(io.BytesIO(response.read()))
        else:
            img = Image.open(image_path_or_url)
    except Exception as e:
        print(f"ERR: Failed to load image - {e}")
        return

    # Convert to RGB
    img = img.convert("RGB")
    
    # Calculate new dimensions
    w, h = img.size
    aspect_ratio = h / w
    # A terminal character is roughly twice as tall as it is wide
    # And we use half-blocks which halves the height again, so actually 1 char = 2 pixels high.
    new_w = min(w, max_width)
    new_h = int(new_w * aspect_ratio) # actual pixels
    
    # Ensure height is even for half-blocks
    if new_h % 2 != 0:
        new_h += 1
        
    img = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
    
    # Render using half-blocks (U+2584)
    # Background color = upper pixel, Foreground color = lower pixel
    for y in range(0, new_h, 2):
        line = ""
        for x in range(new_w):
            r1, g1, b1 = img.getpixel((x, y))
            if y + 1 < new_h:
                r2, g2, b2 = img.getpixel((x, y + 1))
            else:
                r2, g2, b2 = 0, 0, 0
                
            # ANSI True Color: \033[38;2;R;G;Bm (fg) \033[48;2;R;G;Bm (bg)
            line += f"\033[38;2;{r2};{g2};{b2}m\033[48;2;{r1};{g1};{b1}m▄"
            
        print(line + "\033[0m")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 kimg.py <path_or_url>")
        sys.exit(1)
        
    render_image(sys.argv[1])
