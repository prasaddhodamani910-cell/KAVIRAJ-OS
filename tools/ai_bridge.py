#!/usr/bin/env python3
"""
Kaviraj AI — Universal Knowledge Engine
Works 100% FREE without any API key.

Combines multiple free knowledge sources:
  - Wikipedia REST API (facts, history, science, people, places)
  - DuckDuckGo Instant Answers (quick answers)
  - Free Dictionary API (word definitions, phonetics)
  - Built-in engines (math, number spelling, greetings, code, translations)
  - Optional: Google Gemini LLM if user provides API key
"""

import sys
import os
import re
import json
import math
import urllib.request
import urllib.parse

CONFIG_PATH = os.path.expanduser("~/.kaviraj_ai_config.json")
HISTORY_FILE = os.path.expanduser("~/.kaviraj_ai_history.json")

# ──────────────────── CONFIG ────────────────────

def load_config():
    if os.path.exists(CONFIG_PATH):
        try:
            with open(CONFIG_PATH, "r") as f:
                return json.load(f)
        except Exception:
            pass
    return {}

def save_config(cfg):
    try:
        with open(CONFIG_PATH, "w") as f:
            json.dump(cfg, f, indent=2)
    except Exception:
        pass


def load_history():
    if not os.path.exists(HISTORY_FILE):
        return []
    try:
        with open(HISTORY_FILE, "r") as f:
            return json.load(f)
    except:
        return []

def save_history(history):
    # Keep only the last 10 pairs (20 messages)
    if len(history) > 20:
        history = history[-20:]
    try:
        with open(HISTORY_FILE, "w") as f:
            json.dump(history, f)
    except:
        pass

def get_api_key():
    cfg = load_config()
    return cfg.get("api_key", "") or os.environ.get("GEMINI_API_KEY", "")

# ──────────────────── LLM PROVIDERS (ALL FREE) ────────────────────

PROVIDERS = {
    "gemini": {
        "name": "Google Gemini",
        "models": ["gemini-3.6-flash", "gemini-3.6-pro"],
        "url": "https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent?key={key}",
        "build_payload": lambda prompt, model: {
            "contents": [{"role": "user", "parts": [{"text": prompt}]}],
            "generationConfig": {"temperature": 0.8, "maxOutputTokens": 8192}
        },
        "parse_response": lambda data: (data.get("candidates", [{}])[0].get("content", {}).get("parts", [{}])[0].get("text", "")).strip(),
    },
    "groq": {
        "name": "Groq Cloud",
        "models": ["llama-3.3-70b-versatile", "mixtral-8x7b-32768", "gemma2-9b-it"],
        "url": "https://api.groq.com/openai/v1/chat/completions",
        "build_payload": lambda prompt, model: {
            "model": model,
            "messages": [{"role": "user", "content": prompt}],
            "temperature": 0.8,
            "max_tokens": 8192,
        },
        "parse_response": lambda data: (data.get("choices", [{}])[0].get("message", {}).get("content", "")).strip(),
    },
    "openrouter": {
        "name": "OpenRouter",
        "models": ["meta-llama/llama-3.3-70b-instruct:free", "google/gemma-2-9b-it:free"],
        "url": "https://openrouter.ai/api/v1/chat/completions",
        "build_payload": lambda prompt, model: {
            "model": model,
            "messages": [{"role": "user", "content": prompt}],
            "temperature": 0.8,
            "max_tokens": 8192,
        },
        "parse_response": lambda data: (data.get("choices", [{}])[0].get("message", {}).get("content", "")).strip(),
    },
}

def detect_provider(key):
    """Auto-detect which provider the API key belongs to."""
    if not key:
        return None
    if key.startswith("AIza") or key.startswith("AQ."):
        return "gemini"
    elif key.startswith("gsk_"):
        return "groq"
    elif key.startswith("sk-or-"):
        return "openrouter"
    # Try each provider
    return None

def query_llm(prompt, api_key, context_str="", model=None):
    import sys, re
    cfg = load_config()
    provider_name = cfg.get("provider", detect_provider(api_key) or "gemini")
    provider = PROVIDERS.get(provider_name, PROVIDERS["gemini"])
    
    sys_prompt = (
        "You are Kaviraj AI, the intelligent assistant in Kaviraj OS by Prasad Dhodamani. "
        "Answer thoroughly and accurately like ChatGPT. Keep answers clear and well-formatted."
    )
    if "--auto" in sys.argv:
        sys_prompt += (
            "\n\n[AGENT MODE ENABLED - AUTO-IMPLEMENTER]\n"
            "You are an autonomous developer agent with shell access to Kaviraj OS.\n"
            "SECURITY PROTOCOL: You are sandboxed. Do NOT write Python scripts that modify or access the host Android OS or Termux files outside of the virtual environment. If a task requires host OS access, you MUST halt and ask the user for permission.\n"
            "SELF-HEALING PROTOCOL: The system will return the output of your commands. If a Python script crashes, carefully read the Traceback error, rewrite the corrected file using the 'write' command, and re-run it until it succeeds.\n"
            "Commands available: 'write <file> <text>', 'python <file>', 'python -c <code>', 'ls'.\n"
            "To execute a command, wrap it precisely like this: <CMD>command here</CMD>\n"
            "ONLY OUTPUT ONE COMMAND AT A TIME. If the goal is fully achieved, explain the result without a <CMD> tag."
        )

    full_prompt = sys_prompt + "\n\n"
    if context_str:
        full_prompt += "[SYSTEM STATE]\n" + context_str + "\n\n"
    full_prompt += "User: " + prompt

    models_to_try = [model] if model else provider["models"]

    for m in models_to_try:
        try:
            if provider_name == "gemini":
                url = provider["url"].format(model=m, key=api_key)
                headers = {"Content-Type": "application/json"}
            else:
                url = provider["url"]
                headers = {
                    "Content-Type": "application/json",
                    "Authorization": f"Bearer {api_key}",
                }

            payload = provider["build_payload"](full_prompt, m)
            req = urllib.request.Request(url, data=json.dumps(payload).encode(), headers=headers)
            with urllib.request.urlopen(req, timeout=120) as resp:
                data = json.loads(resp.read().decode())
                text = provider["parse_response"](data)
                if text:
                    if "--auto" in sys.argv:
                        cmd_match = re.search(r'<CMD>(.*?)</CMD>', text, re.DOTALL)
                        if cmd_match:
                            return f"__AUTO_EXEC_CMD__:{cmd_match.group(1).strip()}"

                    if cfg.get("model") != m:
                        cfg["model"] = m
                        save_config(cfg)
                    return text
        except Exception:
            continue

    return None

# ──────────────────── WIKIPEDIA ENGINE ────────────────────

def wiki_summary(topic):
    """Get a summary from Wikipedia REST API."""
    slug = topic.strip().replace(" ", "_")
    url = f"https://en.wikipedia.org/api/rest_v1/page/summary/{urllib.parse.quote(slug)}"
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "KavirajOS/1.0"})
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode())
            title = data.get("title", "")
            extract = data.get("extract", "")
            ptype = data.get("type", "")
            if ptype == "disambiguation" or not extract:
                return None
            return title, extract
    except Exception:
        return None

def wiki_search(query):
    """Search Wikipedia and return summary of best result."""
    url = f"https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch={urllib.parse.quote(query)}&format=json&utf8=1&srlimit=5"
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "KavirajOS/1.0"})
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode())
            results = data.get("query", {}).get("search", [])
            # Filter out disambiguation / film / song pages
            media_tags = ["(film)", "(movie)", "(song)", "(album)", "(TV series)", "(band)", "(disambiguation)"]
            for r in results:
                title = r.get("title", "")
                if any(tag.lower() in title.lower() for tag in media_tags):
                    # Skip media unless query explicitly mentions media
                    if not any(w in query.lower() for w in ["film", "movie", "song", "album", "tv series", "band"]):
                        continue
                result = wiki_summary(title)
                if result:
                    return result
    except Exception:
        pass
    return None

# ──────────────────── DUCKDUCKGO INSTANT ANSWERS ────────────────────

def ddg_instant(query):
    """Get instant answer from DuckDuckGo."""
    url = f"https://api.duckduckgo.com/?q={urllib.parse.quote(query)}&format=json&no_html=1&skip_disambig=1"
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "KavirajOS/1.0"})
        with urllib.request.urlopen(req, timeout=8) as resp:
            data = json.loads(resp.read().decode())
            # Try different answer types
            for field in ["AbstractText", "Answer", "Definition"]:
                text = data.get(field, "")
                if text and len(text) > 20:
                    source = data.get("AbstractSource", "") or data.get("DefinitionSource", "")
                    heading = data.get("Heading", "")
                    return heading, text, source
    except Exception:
        pass
    return None

# ──────────────────── DICTIONARY ENGINE ────────────────────

def dictionary_lookup(word):
    """Look up word definition using Free Dictionary API."""
    word = word.strip().lower()
    url = f"https://api.dictionaryapi.dev/api/v2/entries/en/{urllib.parse.quote(word)}"
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "KavirajOS/1.0"})
        with urllib.request.urlopen(req, timeout=8) as resp:
            data = json.loads(resp.read().decode())
            if not data or not isinstance(data, list):
                return None
            entry = data[0]
            result = f"\033[1;33m{entry.get('word', word).capitalize()}\033[0m"
            phonetic = entry.get("phonetic", "")
            if phonetic:
                result += f"  {phonetic}"
            result += "\n"
            for meaning in entry.get("meanings", [])[:3]:
                pos = meaning.get("partOfSpeech", "")
                result += f"\n  \033[1;36m({pos})\033[0m"
                for d in meaning.get("definitions", [])[:2]:
                    defn = d.get("definition", "")
                    result += f"\n    • {defn}"
                    example = d.get("example", "")
                    if example:
                        result += f'\n      \033[2mExample: "{example}"\033[0m'
            return result
    except Exception:
        return None

# ──────────────────── NUMBER & MATH ENGINE ────────────────────

def number_to_words(n):
    if n == 0: return "zero"
    if n < 0: return "negative " + number_to_words(-n)
    ones = ["","one","two","three","four","five","six","seven","eight","nine",
            "ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen",
            "seventeen","eighteen","nineteen"]
    tens_w = ["","","twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety"]
    def h(num):
        if num < 20: return ones[num]
        elif num < 100: return tens_w[num//10] + ("-"+ones[num%10] if num%10 else "")
        elif num < 1000: return ones[num//100]+" hundred"+((" "+h(num%100)) if num%100 else "")
        elif num < 1000000: return h(num//1000)+" thousand"+((" "+h(num%1000)) if num%1000 else "")
        elif num < 1000000000: return h(num//1000000)+" million"+((" "+h(num%1000000)) if num%1000000 else "")
        else: return h(num//1000000000)+" billion"+((" "+h(num%1000000000)) if num%1000000000 else "")
    return h(n)

def to_roman(n):
    if n <= 0 or n > 3999: return str(n)
    vals = [(1000,'M'),(900,'CM'),(500,'D'),(400,'CD'),(100,'C'),(90,'XC'),
            (50,'L'),(40,'XL'),(10,'X'),(9,'IX'),(5,'V'),(4,'IV'),(1,'I')]
    r = ""
    for v, s in vals:
        while n >= v: r += s; n -= v
    return r

def try_number_spelling(q):
    m = re.search(r'(?:spelling\s+(?:of\s+)?|spell\s+|write\s+|in\s+words\s*)(\d+)', q)
    if not m:
        m = re.search(r'(\d+)\s*(?:in\s+words|spelling)', q)
    if m:
        n = int(m.group(1))
        words = number_to_words(n).capitalize()
        result = f"The spelling of {n} is \033[1;32m{words}\033[0m."
        if n <= 3999:
            result += f"\n  • Roman Numeral: {to_roman(n)}"
        result += f"\n  • Type: {'Even' if n % 2 == 0 else 'Odd'}"
        return result
    return None

def try_math(q):
    # Basic arithmetic: "25 * 16" or "what is 25 * 16"
    m = re.search(r'(\d+(?:\.\d+)?)\s*([+\-*/x×÷%^])\s*(\d+(?:\.\d+)?)', q)
    if m:
        a, op, b = float(m.group(1)), m.group(2), float(m.group(3))
        if op in ('x', '×'): op = '*'
        if op == '÷': op = '/'
        try:
            if op == '+': r = a + b
            elif op == '-': r = a - b
            elif op == '*': r = a * b
            elif op == '%': r = a % b
            elif op == '^': r = a ** b
            elif op == '/':
                if b == 0: return "Error: Division by zero."
                r = a / b
            else: return None
            if r == int(r): r = int(r)
            if a == int(a): a = int(a)
            if b == int(b): b = int(b)
            return f"\033[1;32m{a} {op} {b} = {r}\033[0m"
        except Exception:
            return None
    # Square root
    m = re.search(r'(?:square\s*root|sqrt)\s*(?:of\s*)?(\d+)', q)
    if m:
        n = int(m.group(1))
        r = math.sqrt(n)
        if r == int(r): r = int(r)
        return f"√{n} = \033[1;32m{r}\033[0m"
    # Factorial
    m = re.search(r'(?:factorial)\s*(?:of\s*)?(\d+)', q)
    if m:
        n = int(m.group(1))
        if n <= 20:
            return f"{n}! = \033[1;32m{math.factorial(n)}\033[0m"
    # Percentage
    m = re.search(r'(\d+(?:\.\d+)?)\s*%\s*of\s*(\d+(?:\.\d+)?)', q)
    if m:
        pct, val = float(m.group(1)), float(m.group(2))
        r = pct * val / 100
        if r == int(r): r = int(r)
        return f"{pct}% of {val} = \033[1;32m{r}\033[0m"
    return None

# ──────────────────── HOLIDAYS & OBSERVANCES ────────────────────

HOLIDAYS = {
    "womens day": ("International Women's Day", "8 March",
        "International Women's Day is celebrated annually on March 8, honoring women's social, economic, cultural, and political achievements worldwide. It also marks a call to action for gender equality and women's rights."),
    "women's day": ("International Women's Day", "8 March",
        "International Women's Day is celebrated annually on March 8, honoring women's social, economic, cultural, and political achievements worldwide. It also marks a call to action for gender equality and women's rights."),
    "mothers day": ("Mother's Day", "2nd Sunday of May",
        "Mother's Day is a celebration honoring mothers and motherhood. It is observed on the second Sunday of May in many countries."),
    "fathers day": ("Father's Day", "3rd Sunday of June",
        "Father's Day is a celebration honoring fathers and fatherhood. It is observed on the third Sunday of June in many countries."),
    "earth day": ("Earth Day", "22 April",
        "Earth Day is observed annually on April 22 to demonstrate support for environmental protection. It was first celebrated in 1970."),
    "independence day": ("Independence Day (India)", "15 August",
        "India's Independence Day is celebrated on August 15 to commemorate the nation's independence from British rule in 1947."),
    "republic day": ("Republic Day (India)", "26 January",
        "India's Republic Day is celebrated on January 26 to honor the date the Constitution of India came into effect in 1950."),
    "teachers day": ("Teachers' Day (India)", "5 September",
        "Teachers' Day is celebrated in India on September 5, the birthday of Dr. Sarvepalli Radhakrishnan, to honor educators."),
    "childrens day": ("Children's Day (India)", "14 November",
        "Children's Day in India is celebrated on November 14, the birthday of Pandit Jawaharlal Nehru, India's first Prime Minister."),
    "christmas": ("Christmas", "25 December",
        "Christmas is an annual festival commemorating the birth of Jesus Christ, observed on December 25 as a religious and cultural celebration."),
    "new year": ("New Year's Day", "1 January",
        "New Year's Day is the first day of the year in the Gregorian calendar, celebrated worldwide on January 1."),
    "valentine": ("Valentine's Day", "14 February",
        "Valentine's Day is observed on February 14 each year as a celebration of love and affection."),
    "halloween": ("Halloween", "31 October",
        "Halloween is celebrated on October 31, originating from the Celtic festival of Samhain. It involves costumes, trick-or-treating, and spooky themes."),
    "labor day": ("International Workers' Day", "1 May",
        "International Workers' Day (May Day) is celebrated on May 1 to honor workers and the labor movement worldwide."),
    "yoga day": ("International Day of Yoga", "21 June",
        "International Yoga Day is observed on June 21 annually, declared by the United Nations in 2014 to raise awareness about yoga's benefits."),
    "science day": ("National Science Day (India)", "28 February",
        "National Science Day is celebrated in India on February 28 to mark the discovery of the Raman Effect by Sir C.V. Raman in 1928."),
}

def try_holiday(q):
    q_clean = re.sub(r'[^a-z0-9\s]', '', q.lower()).strip()
    for key, (name, date, desc) in HOLIDAYS.items():
        if key in q_clean:
            return f"\033[1;33m{name}\033[0m ({date})\n{desc}"
    return None

# ──────────────────── GREETINGS & CONVERSATION ────────────────────

GREETINGS = {
    r'\b(hi|hello|hey|hola|namaste|howdy)\b': [
        "Hello! 👋 I'm Kaviraj AI, your intelligent assistant in Kaviraj OS.",
        "How can I help you today? You can ask me about any topic — science, math, history, coding, definitions, and more!",
    ],
    r'\b(good\s*morning)\b': ["Good morning! ☀️ I'm Kaviraj AI. How can I assist you today?"],
    r'\b(good\s*afternoon)\b': ["Good afternoon! I'm Kaviraj AI. What would you like to know?"],
    r'\b(good\s*evening)\b': ["Good evening! 🌙 I'm Kaviraj AI. How can I help?"],
    r'\b(good\s*night)\b': ["Good night! 🌙 Take care, and feel free to come back anytime."],
    r'\b(thank|thanks|thx)\b': ["You're welcome! 😊 Feel free to ask me anything else."],
    r'\b(bye|goodbye|see\s*you)\b': ["Goodbye! 👋 Have a great day!"],
    r'\bwho\s+(are|r)\s+you\b': [
        "I'm \033[1;35mKaviraj AI\033[0m, the intelligent assistant built into Kaviraj OS — a 64-bit ARM operating system created by \033[1mPrasad Dhodamani\033[0m.",
        "I can answer questions, solve math, define words, explain concepts, and much more!",
    ],
    r'\bwho\s+(made|created|built|developed)\s+(you|kaviraj)\b': [
        "\033[1;35mKaviraj OS\033[0m was created by \033[1mPrasad Dhodamani\033[0m.",
        "It's a bare-metal 64-bit ARM operating system with an integrated AI assistant.",
    ],
}

def try_greeting(q):
    for pattern, responses in GREETINGS.items():
        if re.search(pattern, q.lower()):
            return "\n".join(responses)
    return None

# ──────────────────── PROGRAMMING HELP ────────────────────

CODE_EXAMPLES = {
    r'hello\s*world.*python': ('Python — Hello World', 'print("Hello, World!")'),
    r'hello\s*world.*java(?!script)': ('Java — Hello World', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello, World!");\n    }\n}'),
    r'hello\s*world.*javascript|hello\s*world.*js': ('JavaScript — Hello World', 'console.log("Hello, World!");'),
    r'hello\s*world.*c\+\+|hello\s*world.*cpp': ('C++ — Hello World', '#include <iostream>\nint main() {\n    std::cout << "Hello, World!" << std::endl;\n    return 0;\n}'),
    r'hello\s*world.*\bc\b': ('C — Hello World', '#include <stdio.h>\nint main() {\n    printf("Hello, World!\\n");\n    return 0;\n}'),
    r'hello\s*world': ('Python — Hello World', 'print("Hello, World!")'),
    r'sort.*list.*python|python.*sort': ('Python — Sort a List', 'numbers = [5, 2, 8, 1, 9]\nnumbers.sort()  # In-place sort\nprint(numbers)  # [1, 2, 5, 8, 9]\n\n# Or with sorted() for a new list:\nsorted_nums = sorted(numbers)\nprint(sorted_nums)'),
    r'fibonacci.*python|python.*fibonacci': ('Python — Fibonacci', 'def fibonacci(n):\n    a, b = 0, 1\n    for _ in range(n):\n        print(a, end=" ")\n        a, b = b, a + b\n\nfibonacci(10)  # 0 1 1 2 3 5 8 13 21 34'),
    r'reverse.*string.*python|python.*reverse.*string': ('Python — Reverse String', 'text = "Hello"\nreversed_text = text[::-1]\nprint(reversed_text)  # olleH'),
}

def try_code(q):
    for pattern, (title, code) in CODE_EXAMPLES.items():
        if re.search(pattern, q.lower()):
            return f"\033[1;33m{title}\033[0m\n\033[32m{code}\033[0m"
    return None

# ──────────────────── TRANSLATIONS ────────────────────

TRANSLATIONS = {
    "hello": {"Spanish": "Hola", "French": "Bonjour", "German": "Hallo", "Japanese": "こんにちは (Konnichiwa)", "Hindi": "नमस्ते (Namaste)", "Italian": "Ciao", "Korean": "안녕하세요 (Annyeonghaseyo)", "Arabic": "مرحبا (Marhaba)"},
    "good morning": {"Spanish": "Buenos días", "French": "Bonjour", "German": "Guten Morgen", "Japanese": "おはようございます (Ohayō gozaimasu)", "Hindi": "सुप्रभात (Suprabhat)"},
    "thank you": {"Spanish": "Gracias", "French": "Merci", "German": "Danke", "Japanese": "ありがとう (Arigatō)", "Hindi": "धन्यवाद (Dhanyavaad)", "Italian": "Grazie", "Korean": "감사합니다 (Gamsahamnida)"},
    "i love you": {"Spanish": "Te amo", "French": "Je t'aime", "German": "Ich liebe dich", "Japanese": "愛してる (Aishiteru)", "Hindi": "मैं तुमसे प्यार करता हूँ", "Italian": "Ti amo", "Korean": "사랑해 (Saranghae)"},
    "goodbye": {"Spanish": "Adiós", "French": "Au revoir", "German": "Auf Wiedersehen", "Japanese": "さようなら (Sayōnara)", "Hindi": "अलविदा (Alvida)"},
    "how are you": {"Spanish": "¿Cómo estás?", "French": "Comment allez-vous?", "German": "Wie geht es Ihnen?", "Japanese": "お元気ですか (Ogenki desu ka?)", "Hindi": "आप कैसे हैं? (Aap kaise hain?)"},
}

def try_translate(q):
    m = re.search(r'translate\s+["\']?(.+?)["\']?\s+(?:to|in|into)\s+(\w+)', q.lower())
    if m:
        phrase = m.group(1).strip().lower()
        lang = m.group(2).strip().capitalize()
        if phrase in TRANSLATIONS:
            trans = TRANSLATIONS[phrase]
            if lang in trans:
                return f'\033[1;33m"{phrase.title()}"\033[0m in {lang}: \033[1;32m{trans[lang]}\033[0m'
            else:
                result = f'\033[1;33mTranslations of "{phrase.title()}":\033[0m\n'
                for l, t in trans.items():
                    result += f"  • {l}: {t}\n"
                return result.strip()
    # Generic "translate X" without target
    m = re.search(r'translate\s+["\']?(.+?)["\']?\s*$', q.lower())
    if m:
        phrase = m.group(1).strip().lower()
        if phrase in TRANSLATIONS:
            result = f'\033[1;33mTranslations of "{phrase.title()}":\033[0m\n'
            for l, t in TRANSLATIONS[phrase].items():
                result += f"  • {l}: {t}\n"
            return result.strip()
    return None

# ──────────────────── DEFINITION DETECTION ────────────────────

def try_definition(q):
    """Check if user is asking for a word definition."""
    m = re.search(r'(?:define|meaning\s+of|definition\s+of|what\s+does\s+(\w+)\s+mean)\s+(\w+)?', q.lower())
    if m:
        word = m.group(2) or m.group(1)
        if word:
            return dictionary_lookup(word)
    return None

# ──────────────────── MAIN ANSWER ENGINE ────────────────────

def clean_query(q):
    """Extract the actual topic from queries like 'what is X', 'explain X', 'tell me about X'."""
    q = q.strip()
    # Remove common prefixes
    prefixes = [
        r'^(?:what\s+is|what\s+are|what\'s)\s+(?:a\s+|an\s+|the\s+)?',
        r'^(?:who\s+is|who\s+was|who\s+are)\s+(?:a\s+|an\s+|the\s+)?',
        r'^(?:explain|describe|tell\s+me\s+about|talk\s+about)\s+(?:a\s+|an\s+|the\s+)?',
        r'^(?:how\s+does|how\s+do|how\s+is)\s+(?:a\s+|an\s+|the\s+)?',
        r'^(?:when\s+is|when\s+was|when\s+did)\s+(?:a\s+|an\s+|the\s+)?',
        r'^(?:where\s+is|where\s+was)\s+(?:a\s+|an\s+|the\s+)?',
        r'^(?:why\s+is|why\s+are|why\s+do|why\s+does)\s+(?:a\s+|an\s+|the\s+)?',
    ]
    cleaned = q
    for p in prefixes:
        cleaned = re.sub(p, '', cleaned, flags=re.IGNORECASE).strip()
    # Remove trailing question mark
    cleaned = cleaned.rstrip('?').strip()
    return cleaned if cleaned else q

def ask(prompt, context_str=""):
    """Main answer engine — tries all knowledge sources."""
    q = prompt.strip()
    if not q:
        return "Please type a question or prompt."

    # 1. Check if Gemini API key is configured (premium mode)
    api_key = get_api_key()
    if api_key:
        result = query_llm(q, api_key, context_str, load_config().get("model"))
        if result:
            return result

    # 2. Translations (check before greetings so "translate hello" isn't caught)
    result = try_translate(q)
    if result:
        return result

    # 3. Code examples (check before greetings so "hello world in python" works)
    result = try_code(q)
    if result:
        return result

    # 4. Greetings & conversation
    result = try_greeting(q)
    if result:
        return result

    # 3. Number spelling
    result = try_number_spelling(q.lower())
    if result:
        return result

    # 4. Math
    result = try_math(q.lower())
    if result:
        return result

    # 5. Holidays & observances
    result = try_holiday(q)
    if result:
        return result


    # 6. Word definitions
    result = try_definition(q)
    if result:
        return result


    # 7. Knowledge search — Wikipedia + DuckDuckGo
    topic = clean_query(q)

    # Try DuckDuckGo instant answer first (faster)
    ddg = ddg_instant(topic)
    if ddg:
        heading, text, source = ddg
        label = f"\033[1;33m{heading}\033[0m" if heading else ""
        src = f"\033[2m— {source}\033[0m" if source else ""
        return f"{label}\n{text}\n{src}".strip()

    # Try Wikipedia direct lookup
    wiki = wiki_summary(topic)
    if wiki:
        title, extract = wiki
        return f"\033[1;33m{title}\033[0m\n{extract}"

    # Try Wikipedia search
    wiki = wiki_search(topic)
    if wiki:
        title, extract = wiki
        return f"\033[1;33m{title}\033[0m\n{extract}"

    # Also try searching the full original query
    if topic != q.strip():
        wiki = wiki_search(q.strip())
        if wiki:
            title, extract = wiki
            return f"\033[1;33m{title}\033[0m\n{extract}"

    # 10. Try dictionary as last resort for single words
    words = topic.split()
    if len(words) == 1:
        result = dictionary_lookup(words[0])
        if result:
            return result

    # Nothing found
    return (
        f"I couldn't find information about \033[1m\"{q}\"\033[0m.\n"
        "Try rephrasing your question, or ask about:\n"
        "  • Science, history, geography, people\n"
        "  • Math calculations (e.g., 25 * 16)\n"
        "  • Number spellings (e.g., spelling of 17)\n"
        "  • Word definitions (e.g., define algorithm)\n"
        "  • Holidays (e.g., Women's Day)\n"
        "  • Translations (e.g., translate hello to Japanese)\n"
        "  • Code examples (e.g., hello world in Python)\n\n"
        "\033[2mTip: To unlock full AI intelligence, type /setup for an easy step-by-step guide!\033[0m"
    )

# ──────────────────── CLI INTERFACE ────────────────────

def main():
    if len(sys.argv) < 2:
        print("Usage: ai_bridge.py <prompt>")
        sys.exit(1)

    cmd = sys.argv[1]

    if cmd == "--set-key":
        if len(sys.argv) < 3:
            print("Usage: ai_bridge.py --set-key YOUR_API_KEY")
            sys.exit(1)
        key = sys.argv[2].strip()
        if not key or len(key) < 10:
            print("\033[1;31m✗ Key too short.\033[0m")
            sys.exit(1)
        
        # Auto-detect provider
        provider_name = detect_provider(key)
        if not provider_name:
            # Try all providers
            for pname in ["gemini", "groq", "openrouter"]:
                provider_name = pname
                break
            provider_name = provider_name or "gemini"
        
        provider = PROVIDERS[provider_name]
        print(f"Testing API key with {provider['name']}...")
        
        for m in provider["models"]:
            try:
                if provider_name == "gemini":
                    url = provider["url"].format(model=m, key=key)
                    headers = {"Content-Type": "application/json"}
                else:
                    url = provider["url"]
                    headers = {
                        "Content-Type": "application/json",
                        "Authorization": f"Bearer {key}",
                    }
                
                payload = provider["build_payload"]("Say: Key verified!", m)
                req = urllib.request.Request(url, data=json.dumps(payload).encode(), headers=headers)
                with urllib.request.urlopen(req, timeout=20) as resp:
                    data = json.loads(resp.read().decode())
                    text = provider["parse_response"](data)
                    if text:
                        cfg = load_config()
                        cfg["api_key"] = key
                        cfg["provider"] = provider_name
                        cfg["model"] = m
                        save_config(cfg)
                        print(f"\033[1;32m✓ API Key verified!\033[0m Provider: {provider['name']} | Model: {m}")
                        print("Kaviraj AI is now in premium mode — unlimited answers!")
                        sys.exit(0)
            except urllib.error.HTTPError as e:
                if e.code == 400 or e.code == 401:
                    print(f"\033[1;31m✗ Invalid API key for {provider['name']}.\033[0m")
                    print("Get a free key from one of these (all 100% free):")
                    print("  • Google Gemini : https://aistudio.google.com/app/apikey")
                    print("  • Groq Cloud    : https://console.groq.com/keys")
                    print("  • OpenRouter    : https://openrouter.ai/keys")
                    sys.exit(1)
                continue
            except Exception:
                continue
        print("\033[1;31m✗ Could not verify key.\033[0m")
        sys.exit(1)

    elif cmd == "--status":
        cfg = load_config()
        key = cfg.get("api_key", "")
        if key:
            pname = cfg.get("provider", "gemini")
            provider = PROVIDERS.get(pname, PROVIDERS["gemini"])
            print(f"\033[1;32m● PREMIUM MODE\033[0m — {provider['name']} connected")
            print(f"  Model: {cfg.get('model', 'auto')}")
        else:
            print(f"\033[1;32m● FREE MODE\033[0m — Using Wikipedia + DuckDuckGo + Dictionary")
            print(f"  Upgrade: /key <your_key> for unlimited AI (100% free)")

    elif cmd == "--check":
        print("configured" if get_api_key() else "not_configured")

    elif cmd == "--clear-memory":
        if os.path.exists(HISTORY_FILE):
            os.remove(HISTORY_FILE)
        print("AI Memory cleared.")
    else:
        args = sys.argv[1:]
        context_str = ""
        if len(args) >= 2 and args[0] == "--context":
            context_str = args[1]
            args = args[2:]
        
        if "--auto" in sys.argv and not get_api_key():
            print("\n\033[1;36m╭────────────────────────────────────────────────────────────╮\033[0m")
            print("\033[1;36m│\033[0m              \033[1;33mKaviraj AI - Neural Link Setup\033[0m                \033[1;36m│\033[0m")
            print("\033[1;36m╰────────────────────────────────────────────────────────────╯\033[0m\n")
            print("To use the autonomous AI Developer, you need a free API Key.\n")
            print("\033[1mStep 1:\033[0m Go to \033[1;34mhttps://aistudio.google.com/app/apikey\033[0m")
            print("\033[1mStep 2:\033[0m Sign in with Google and click 'Create API Key'")
            print("\033[1mStep 3:\033[0m Copy the long text key.")
            print("\033[1mStep 4:\033[0m Open the Kaviraj AI chat by typing \033[1;32mchat\033[0m in the shell.")
            print("\033[1mStep 5:\033[0m Type \033[1;32m/key \033[0m followed by your key and press Enter.\n")
            print("\033[2mExample: /key AIzaSy...\033[0m\n")
            sys.exit(0)
        
        prompt = " ".join(args)
        print(ask(prompt, context_str))

if __name__ == "__main__":
    main()
