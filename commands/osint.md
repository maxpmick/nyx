---
description: OSINT investigation on a target
---
Conduct an OSINT investigation on: $ARGUMENTS

Determine the target type (domain, person, email, IP, organization) and apply the appropriate methodology. Use web search for live lookups. Document everything with nyx-memory tools. Wrap tool executions with `nyx-log`.

## Domain / Organization

- WHOIS, registrar, registration/expiration history
- DNS records (A, AAAA, MX, TXT, NS, SOA, SPF, DMARC, DKIM)
- Subdomain enumeration:
  ```
  nyx-log subfinder -d $DOMAIN -o subfinder.txt
  nyx-log amass enum -passive -d $DOMAIN -o amass.txt
  ```
- Certificate transparency logs (`crt.sh`)
- Technology stack: `nyx-log whatweb $DOMAIN`
- Email format discovery and employee enumeration via web search (LinkedIn, GitHub, public sources)
- Data breach exposure checks via web search
- Public document metadata: `nyx-log metagoofil -d $DOMAIN -t pdf,doc,xls -o meta/`
- Social media presence and official accounts
- Infrastructure mapping: ASN, IP ranges, CDN, hosting provider
- Google dorking for exposed files, directories, login pages

Use `host_discover` for every domain/IP discovered. Use `finding_add` for exposed sensitive data, leaked credentials, or security misconfigurations found in public sources.

## Person

- Username enumeration: `nyx-log sherlock $USERNAME --output sherlock.txt`
- Email discovery and verification
- Social media profiles and activity patterns
- Professional presence via web search (LinkedIn, company pages, conference talks)
- Associated domains, organizations, or projects
- Published code (GitHub, GitLab), documents, or forum posts
- Photo and metadata analysis if applicable

## Email

- Validate email format and deliverability
- Breach exposure via web search for publicly reported breaches
- Associated accounts: `nyx-log holehe $EMAIL`
- Domain analysis for the email provider
- Linked social media and professional profiles

## IP Address

- Reverse DNS and PTR records
- Geolocation, ASN, CIDR ownership
- Passive service/port data via web search (Shodan, Censys references)
- Reputation checks and blacklist status
- Historical data, related infrastructure, and co-hosted domains

## Documentation

- `host_discover` for every IP/domain found
- `finding_add` for any security-relevant discoveries (leaked creds, exposed data, misconfigs)
- `credential_add` for any credentials found in public breaches or exposed repositories
- `evidence_save` for raw tool output and search results
- `attack_path_update` if OSINT reveals a viable initial access vector (e.g., credential reuse, exposed admin panel)
- `executive_summary_update` with OSINT highlights at the end

Build a profile connecting all discovered information. Flag anything actionable for social engineering or initial access.
