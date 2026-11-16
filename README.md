# 🤖 Autonomous Software Engineering Agent

An AI-powered multi-agent software engineering system that autonomously understands an existing GitHub repository, identifies code relevant to a given GitHub issue, plans required modifications, implements changes, executes real tests, debugs failures, reviews the final implementation, and pushes the completed changes to a forked GitHub repository.

---

## 🏗️ System Architecture

```text
GitHub Repository + Issue
       │
       ▼
1. Pre-Execution Validation (5 sequential checks)
       │
       ▼
2. Repository Forking (fork into authenticated user account)
       │
       ▼
3. Isolated Execution Setup (Docker container / Sandbox)
       │
       ▼
4. Clone Repository & Dependency Setup
       │
       ▼
5. Repository Understanding (AST, file tree, test discovery)
       │
       ▼
6. Planner Agent (problem hypothesis, task breakdown)
       │
       ▼
7. Coder Agent (real file modification in repository)
       │
       ▼
8. Tester Agent (Pytest execution inside container)
       ├── Tests Pass ──┐
       │                │
       ▼ Tests Fail     │
9. Debugger Agent       │
       │                │ (Max 3 attempts)
       ▼                │
10. Code Editor Agent   │
       │                │
       └─── Loop back ──┘
                        │
                        ▼
11. Reviewer Agent (Git diff inspection, security, code quality)
       │
       ▼
12. Commit & Push Changes (branch push to user's fork)
       │
       ▼
13. Final Execution Report & PR Summary
```

---

## 💻 Tech Stack

| Component | Technology |
|---|---|
| **Frontend** | Streamlit |
| **Backend** | FastAPI & Uvicorn |
| **Language** | Python 3.11 |
| **Version Control** | GitPython / GitHub REST API |
| **Isolated Execution** | Docker Container (`python:3.11-slim`) / Host Sandbox |
| **Testing** | Pytest |
| **LLM Integration** | Configurable (Gemini, OpenAI, Groq, Ollama) |
| **Event Streaming** | Server-Sent Events (SSE) & REST |

---

## 🚀 Getting Started

### 1. Prerequisites
- Python 3.11
- Git installed on your system
- (Optional) Docker Desktop running

### 2. Environment Configuration
Create or configure `.env` in the root directory:

```env
# GitHub Credentials
GITHUB_TOKEN=your_github_personal_access_token_here
GITHUB_USERNAME=your_github_username_here

# LLM Configuration (Optional - can also enter in Streamlit UI)
LLM_PROVIDER=gemini       # Options: gemini, openai, groq
GEMINI_API_KEY=your_gemini_api_key_here
OPENAI_API_KEY=your_openai_api_key_here

# Execution Environment
DOCKER_IMAGE=python:3.11-slim
```

### 3. Installation

Activate your virtual environment and install dependencies:

```bash
# If using Windows PowerShell
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirement.txt
```

---

## 🖥️ Running the Application

### Option A: One-Click Startup (Windows)
Double-click `run.bat` or run:
```cmd
run.bat
```

### Option B: Manual Execution

#### Terminal 1 — FastAPI Backend:
```bash
venv\Scripts\uvicorn.exe backend.main:app --host 127.0.0.1 --port 8000 --reload
```
API Documentation will be available at: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

#### Terminal 2 — Streamlit Frontend:
```bash
venv\Scripts\streamlit.exe run frontend/app.py --server.port 8501
```
Open your browser to: [http://localhost:8501](http://localhost:8501)

---

## 🧪 Running Automated Tests

Run the full pytest suite:

```bash
venv\Scripts\python.exe -m pytest tests/ -v
```

Tests verify:
- GitHub URL syntax & accessibility validation
- Execution environment setup & command execution
- Repository service (file tree generation, dependency detection, file reading/writing, git diffing)
- Multi-agent pipeline (Understanding → Planner → Coder → Tester → Debugger → Code Editor → Reviewer)
- FastAPI backend routes and workflow state management

---

## 🛡️ Security & Integrity Principles
- **Target Repository Safety**: The original repository is NEVER modified. All operations target a fork.
- **Credential Protection**: Personal Access Tokens and API keys are masked and never written to repository commits.
- **Isolated Execution**: Commands and tests execute in an isolated environment with timeout bounds.
- **Genuine Execution**: Real Git branches, commits, diffs, and Pytest executions are performed.
