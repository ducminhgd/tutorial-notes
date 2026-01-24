# Install Claude code local

https://ollama.com/blog/claude

1. Install Ollama https://ollama.com/
2. Pull model

    ```bash
    ollama pull bjoernb/claude-opus-4-5
    ```

    or

    ```bash
    ollama pull qwen3-coder
    ```

3. Install Anthropic Claude code

    ```bash
    npm install -g @anthropic-ai/claude-code
    ```

4. Set virtual environment

    ```bash
    export ANTHROPIC_AUTH_TOKEN=ollama
    export ANTHROPIC_BASE_URL=http://localhost:11434
    ```

    or, on Windows

    ```shell
    set ANTHROPIC_AUTH_TOKEN=ollama
    set ANTHROPIC_BASE_URL=http://localhost:11434
    ```

5. Run

    ```bash
    claude --model qwen3-coder
    ```
