# Self-hosted deployment

Docker + nginx deployment for Qwerty Learner, prepared for a LAN instance.

## Requirements

- Docker with the Compose plugin
- Port `8990` free on the host

## Build and run

```bash
./deploy.sh
```

The script builds `qwerty-learner:local`, then recreates the Compose service.
It uses the classic Docker builder because this environment has no buildx.

## Access

- Desktop app: `http://<host-ip>:8990/`
- Mobile: `http://<host-ip>:8990/mobile`

The typing app is desktop-only upstream. Mobile visitors stay on the
`/mobile` landing page; there is no mobile typing route in this fork.

## What is bundled

- 380 dictionaries under `public/dicts`, including PEP grades 3–9, 中考, 高考,
  CET-4/6, IELTS and TOEFL word lists.
- The UI and dictionaries work without internet access.

## Notes

- Word pronunciation still calls `https://dict.youdao.com/dictvoice`. It needs
  outbound internet access and is not covered by any Youdao SLA.
- Progress is stored in each browser's IndexedDB, so PC and phone do not sync.
- The upstream landing page hardcoded `https://qwerty.kaiyi.cool/`; this fork
  points those links at the local `/` instead, so they never leave this host.
- Mobile `/` still redirects to `/mobile`, matching upstream behavior.
