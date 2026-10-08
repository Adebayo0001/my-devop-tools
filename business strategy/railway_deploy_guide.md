# Deploying the Telegram Bot to Railway (Always-On, No Laptop Required)

Railway.app gives you a free always-on Node.js server.
Once deployed, the bot runs 24/7 and sends posts for approval even when your laptop is off.

---

## Step 1: Create a Railway Account

1. Go to https://railway.app
2. Sign up with your GitHub account (free)

---

## Step 2: Push the Bot Script to GitHub

The bot needs to be in its own small GitHub repo. Create a new repo at github.com called `adebayo-publisher-bot` and push these three files:

### File 1: `index.js`
Copy the contents of `C:\Users\user\Desktop\Lifestream\scripts\telegram_listener.js` into `index.js`

### File 2: `package.json`
```json
{
  "name": "adebayo-publisher-bot",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  }
}
```

### File 3: `content/approved/active_draft.md`
Copy your current `active_draft.md` into the same path.

---

## Step 3: Deploy to Railway

1. On Railway dashboard → click **New Project**
2. Select **Deploy from GitHub Repo**
3. Select `adebayo-publisher-bot`
4. Railway auto-detects Node.js and runs `npm start`

---

## Step 4: Add Environment Variables on Railway

In your Railway project → **Variables** tab, add:

| Variable | Value |
| :--- | :--- |
| `TELEGRAM_BOT_TOKEN` | `8244904113:AAFQl9uUosHU_SIBiicaP7jg9fIxC-GLUGk` |
| `TELEGRAM_CHAT_ID` | `1239664248` |
| `MAKE_WEBHOOK_URL` | `https://hook.us2.make.com/1vs4bblha73d3im2ws9d5g7siaiu7vdb` |

---

## Step 5: Add Posts to the Queue

To schedule multiple posts for a day, add `.md` files to `content/queue/` named alphabetically in order:

```
content/queue/
  01-tuesday-engineering-post.md
  02-thursday-policy-post.md
  03-saturday-industry-post.md
```

When you approve post 01, the bot immediately sends post 02 for your review. No laptop needed.

---

## How the Queue Works

1. Bot boots → reads all `.md` files from `content/queue/` sorted alphabetically
2. Sends **Post 1** to your Telegram for review
3. You tap **Approve** → Post 1 goes to Buffer → LinkedIn & Instagram
4. Bot **automatically** sends **Post 2** for your review
5. Repeat until all posts in queue are approved
6. Bot sends "All done for today!" confirmation

---

## Cost

**Free tier on Railway**: 500 execution hours/month = 20+ days of always-on runtime.
For full month coverage, upgrade is $5/month.
