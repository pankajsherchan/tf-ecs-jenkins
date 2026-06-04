#!/usr/bin/env python3
import json
import os
import re
import sys


PLACEHOLDER_PATTERN = re.compile(r"\$\{[A-Z0-9_]+\}")
REQUIRED_ENV_VARS = [
    "AWS_REGION",
    "EXECUTION_ROLE_ARN",
    "IMAGE_URI",
    "TASK_FAMILY",
]


def render(value, replacements):
    if isinstance(value, str):
        for placeholder, replacement in replacements.items():
            value = value.replace(placeholder, replacement)
        return value

    if isinstance(value, list):
        return [render(item, replacements) for item in value]

    if isinstance(value, dict):
        return {key: render(item, replacements) for key, item in value.items()}

    return value


def main():
    if len(sys.argv) != 3:
        raise SystemExit("Usage: render-task-definition.py TEMPLATE_PATH OUTPUT_PATH")

    missing = [name for name in REQUIRED_ENV_VARS if not os.environ.get(name)]
    if missing:
        raise SystemExit(f"Missing required environment variables: {', '.join(missing)}")

    template_path = sys.argv[1]
    output_path = sys.argv[2]

    replacements = {
        f"${{{name}}}": os.environ[name]
        for name in REQUIRED_ENV_VARS
    }

    with open(template_path) as f:
        task_definition = render(json.load(f), replacements)

    rendered_text = json.dumps(task_definition, indent=2)
    unresolved = sorted(set(PLACEHOLDER_PATTERN.findall(rendered_text)))
    if unresolved:
        raise SystemExit(f"Unresolved task definition placeholders: {', '.join(unresolved)}")

    with open(output_path, "w") as f:
        f.write(rendered_text)
        f.write("\n")


if __name__ == "__main__":
    main()
