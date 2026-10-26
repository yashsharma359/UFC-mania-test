# UFC Mania — Deployment Package

## What this project actually is
This is a **static site**: one self-contained `index.html` file with all CSS and
JavaScript inlined, plus the fighter dataset inlined as JavaScript. There is
**no backend, no database, and no API calls** in this build — "the database"
is a JavaScript array loaded in the browser. That matters for a few of the
requirements you listed:

- **Environment variables for API/DB URLs** — not applicable yet, because
  there is no external API or database to point at. Nothing is hidden that
  needs to be, and there are no private keys anywhere in the code (verified:
  zero occurrences of `localhost`, `127.0.0.1`, or any API key).
- **CORS** — not applicable yet, for the same reason: the page makes no
  cross-origin requests.
- **Routing** — this app uses **hash-based routing** (URLs look like
  `https://yoursite.com/#/fighter/jon-jones`, not `/fighters/jon-jones`).
  This is a deliberate choice for a single static file: the browser never
  asks the server for `/fighter/jon-jones`, so there is nothing for the
  server to 404 on — **refreshing any page always works**, on any static
  host, with zero server configuration. The trade-off is the `#` in the URL
  and slightly weaker default SEO than true server-rendered routes. If you
  want real path-based URLs later (e.g. for SEO), that requires rebuilding
  this as a Next.js app with a server — a bigger, separate project.

Once you deploy the file below, the site works identically on Chrome,
Firefox, Edge, Safari, Opera, Android, iPhone, iPad, Windows, and Mac,
because it's plain HTML/CSS/JS with no platform-specific code, and requires
no login to view.

## Files in this package
- `index.html` — the entire website
- `vercel.json` — Vercel config (routes all paths to `index.html`, sets cache headers)
- `netlify.toml` — equivalent config if you use Netlify instead
- `package.json` — lets Vercel/Netlify recognize this as a project named `ufcmania`

---

## Step-by-step: deploy to Vercel (recommended, free)

**1. Where to deploy:** [vercel.com](https://vercel.com)

**2. Account you need:** A free Vercel account. Sign up with GitHub, GitLab,
Bitbucket, or email — GitHub is easiest for step 4.

**3 & 4. Connect the project** (two ways — pick one):

**Option A — no Git, fastest:**
- Go to vercel.com → click **Add New… → Project**
- Choose **"Deploy without Git"** / drag-and-drop the project folder onto the page
- Drag the folder containing `index.html`, `vercel.json`, and `package.json` in
- Vercel detects it as a static site automatically (no framework, no build command needed)

**Option B — with GitHub (better for updating later):**
- Create a new repository on [github.com](https://github.com) (e.g. `ufcmania`)
- Upload these files to it (via GitHub's web "Add file → Upload files", or `git push` if you use Git)
- In Vercel, click **Add New… → Project → Import Git Repository**, and select that repo
- Framework preset: **Other** (it's static — no build step needed)
- Leave Build Command and Output Directory blank

**5. Deploy it:** Click **Deploy**. It takes under a minute since there's no build step.

**6. Get the public URL:** Vercel shows you a live link immediately after deploy,
in the form `https://<project-name>-<random>.vercel.app`. During project setup
you can set the **Project Name** to `ufcmania` — if that exact name is free on
Vercel's shared domain space, your URL will be `https://ufcmania.vercel.app`;
if it's taken, Vercel will assign the closest available variant (e.g.
`ufcmania-yourname.vercel.app`). I can't confirm which you'll get without you
actually creating the project — Vercel doesn't expose name availability via
any tool I have access to.

**7. How other people open it:** Once deployed, the URL is a normal public
web address — anyone can type or tap it on any phone, tablet, or computer, on
any network, with no account and no login. Share the link exactly as Vercel
gives it to you.

**8. Updating the site later:**
- **Option A (drag-and-drop):** go back to your Vercel project → Deployments →
  drag in the updated folder again
- **Option B (GitHub):** push/upload the changed `index.html` to the repo —
  Vercel automatically redeploys on every push, and you get a live URL update
  within about a minute

---

## Alternative: Netlify (also free)
1. Go to [netlify.com](https://netlify.com) → sign up (free)
2. **Add new site → Deploy manually** → drag in the project folder (or connect a GitHub repo the same way as Vercel)
3. Netlify auto-detects the static site and deploys immediately
4. You get a URL like `https://ufcmania.netlify.app` if that name is available,
   or a random subdomain otherwise — same caveat as Vercel, I can't guarantee
   the exact name until you claim it
5. To update later: re-drag the folder, or push to the connected repo

---

## Production checklist (verified where I can, from the code itself)
| Check | Status |
|---|---|
| No `localhost`/`127.0.0.1` references | ✅ confirmed (0 occurrences) |
| No private API keys in frontend code | ✅ confirmed (no API calls exist in this build) |
| Homepage opens without login | ✅ static file, no auth |
| Works on any modern browser/device | ✅ plain HTML/CSS/JS, no platform-specific APIs |
| Refreshing a fighter profile page doesn't 404 | ✅ by design — hash routing never asks the server for a sub-path |
| Fighter photos load / fall back gracefully | ✅ falls back to a branded "UFC MANIA + initials" placeholder — see note below |
| Mobile layout | ✅ responsive CSS, tested down to ~360px width in the code (grids, nav, profile header all collapse to single-column) |
| CORS issues | Not applicable — no cross-origin requests in this build |
| Database/API works from deployed site | Not applicable yet — the fighter data is bundled into the page, not fetched from a live database |

**On photos:** this build still uses the branded initials placeholder for
every fighter rather than hotlinked photos (explained in an earlier reply —
briefly, I wasn't able to verify+license real photos to a standard I was
comfortable shipping). That's unaffected by deployment — it'll look the same
in production as it does now. Real photos can be layered in later without
any redeploy-workflow changes, since they're just a `photoUrl` field per fighter.

## Once it's live, please spot-check yourself
I can validate everything in the code (no localhost, no exposed keys, routing
behavior, responsive CSS) but I can't browse your live Vercel URL after you
create it. Please click through: homepage, `#/fighters`, a couple of fighter
profiles, `#/compare`, `#/countries`, `#/rankings`, `#/news`, and try it on
your phone — and let me know if anything looks off.
