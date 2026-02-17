---
name: cosign
description: Sign and verify OCI containers, blobs, and artifacts using Sigstore. Supports keyless signing with Fulcio/Rekor, hardware/KMS signing, and manual key-pair generation. Use when securing software supply chains, verifying image integrity, or performing container security audits during penetration testing or DevSecOps workflows.
---

# cosign

## Overview
Cosign is a tool for Container Signing, Verification, and Storage in an OCI registry. It is part of the Sigstore project and aims to make signing and verifying software artifacts (like Docker images) seamless. Category: Exploitation / Web Application Testing / Software Supply Chain Security.

## Installation (if not already installed)
Assume cosign is already installed. If you get a "command not found" error:

```bash
sudo apt install cosign
```

## Common Workflows

### Generate a key-pair
```bash
cosign generate-key-pair
```
This generates `cosign.key` and `cosign.pub`.

### Sign a container image
```bash
cosign sign --key cosign.key user/demo:latest
```

### Verify a container image
```bash
cosign verify --key cosign.pub user/demo:latest
```

### Keyless signing (using OIDC)
```bash
cosign sign <image-uri>
```
This will trigger a browser-based OIDC flow to sign using the Sigstore public good infrastructure.

### Sign a local file (blob)
```bash
cosign sign-blob --key cosign.key myfile.txt --output-signature myfile.sig
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Help for cosign |
| `--output-file` | Log output to a specific file |
| `-t`, `--timeout` | Timeout for commands (default: 3m0s) |
| `-d`, `--verbose` | Log debug output |

### Commands

| Command | Description |
|---------|-------------|
| `attach` | Provides utilities for attaching artifacts to other artifacts in a registry |
| `attest` | Attest the supplied container image |
| `attest-blob` | Attest the supplied blob |
| `bundle` | Interact with a Sigstore protobuf bundle |
| `clean` | Remove all signatures from an image |
| `completion` | Generate completion script |
| `copy` | Copy the supplied container image and signatures |
| `dockerfile` | Discover images in and perform operations on Dockerfiles |
| `download` | Download artifacts and attached artifacts from a registry |
| `env` | Prints Cosign environment variables |
| `generate` | Generates (unsigned) signature payloads from the supplied container image |
| `generate-key-pair` | Generates a private/public key-pair |
| `help` | Help about any command |
| `import-key-pair` | Imports a PEM-encoded RSA or EC private key |
| `initialize` | Initializes SigStore root to retrieve trusted certificate and key targets |
| `load` | Load a signed image on disk to a remote registry |
| `login` | Log in to a registry |
| `manifest` | Discover images in and perform operations on Kubernetes manifests |
| `public-key` | Gets a public key from the key-pair |
| `save` | Save the container image and associated signatures to disk |
| `sign` | Sign the supplied container image |
| `sign-blob` | Sign the supplied blob, outputting base64-encoded signature to stdout |
| `tree` | Display supply chain security artifacts (signatures, SBOMs, attestations) |
| `triangulate` | Outputs the located cosign image reference (storage location) |
| `trusted-root` | Interact with a Sigstore protobuf trusted root |
| `upload` | Upload artifacts to a registry |
| `verify` | Verify a signature on the supplied container image |
| `verify-attestation` | Verify an attestation on the supplied container image |
| `verify-blob` | Verify a signature on the supplied blob |
| `verify-blob-attestation` | Verify an attestation on the supplied blob |
| `version` | Prints the version |

## Notes
- **Keyless Mode**: By default, cosign uses "Keyless signing" via the Sigstore public good Fulcio CA and Rekor transparency log.
- **Registry Access**: Ensure you are authenticated to the OCI registry (e.g., `docker login`) before attempting to sign or verify remote images.
- **Hardware Support**: While cosign supports PIV and PKCS11, the standard Kali package may require specific builds or environment configurations for hardware tokens.