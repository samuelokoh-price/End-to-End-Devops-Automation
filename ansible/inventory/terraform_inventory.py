#!/usr/bin/env python3
import json
import subprocess

def terraform_outputs():
    result = subprocess.run(
        ["terraform", "output", "-json"],
        capture_output=True,
        text=True,
        check=True
    )
    return json.loads(result.stdout)

def main():
    outputs = terraform_outputs()
    ip = outputs["instance_public_ip"]["value"]

    inventory = {
        "all": {
            "hosts": [ip],
            "vars": {
                "ansible_user": "ubuntu",
                "ansible_ssh_private_key_file": "~/.ssh/clw-kpair.pem"
            }
        }
    }

    print(json.dumps(inventory))

if __name__ == "__main__":
    main()
