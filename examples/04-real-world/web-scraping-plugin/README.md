# Web Scraping & Automation Plugin 🌐

**Version:** 2.0.0
**Complexity:** ⭐⭐⭐⭐ Advanced
**MCP Integration:** Puppeteer

Comprehensive web scraping and browser automation plugin using Puppeteer MCP for data extraction, testing, and monitoring.

---

## 📋 Overview

This plugin provides powerful web scraping and browser automation capabilities through Puppeteer MCP integration. Extract data from any website, automate repetitive tasks, generate screenshots, and more.

### Components

- **4 Commands:** scrape, automate-task, extract-data, screenshot
- **1 Agent:** Scraping Expert (strategy design, anti-bot techniques)
- **1 MCP Server:** Puppeteer (browser automation)

### Key Features

✅ **Static & Dynamic Content** - Scrape both traditional and JavaScript-rendered sites
✅ **Browser Automation** - Automate form filling, clicking, navigation
✅ **Data Extraction** - Structured data extraction with custom schemas
✅ **Visual Capture** - Screenshots and PDF generation
✅ **Anti-Bot Techniques** - Stealth mode, proxy rotation, human-like behavior
✅ **Performance Optimized** - Parallel scraping, resource blocking
✅ **Error Resilient** - Retry logic, exponential backoff
✅ **Legal Compliance** - robots.txt checking, rate limiting

---

## 🚀 Installation

### 1. Install Plugin

```bash
# From real-world marketplace
/plugin marketplace add ./examples/marketplaces/real-world-marketplace
/plugin install web-scraping@real-world-examples
```

### 2. MCP Setup

The Puppeteer MCP server is automatically installed via npm:

```json
{
  "mcpServers": {
    "puppeteer": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-puppeteer"],
      "env": {}
    }
  }
}
```

**No authentication required** - Puppeteer runs locally.

### 3. Verify Installation

```bash
/plugin
# Should show "web-scraping" in the list

# Try first command
/scrape https://example.com
```

---

## 📚 Commands

### 1. `/scrape [url]` - Web Scraping

Scrape data from websites using browser automation.

**Capabilities:**
- Static HTML extraction
- JavaScript-rendered content
- Infinite scroll handling
- Pagination navigation
- Authentication flows
- API interception

**Examples:**

```bash
# Simple scraping
/scrape https://example.com/products

# With extraction pattern
/scrape https://example.com/blog --selector ".article" --fields "title,date,author"

# With pagination
/scrape https://example.com/products --paginate ".next-button" --max-pages 10

# Extract structured data
/scrape https://example.com/product/123 --schema json-ld

# With authentication
/scrape https://members.example.com --login --credentials-env SITE_CREDENTIALS
```

**Output Formats:** JSON, CSV, Markdown, Excel

---

### 2. `/automate-task [description]` - Task Automation

Automate repetitive browser tasks.

**Use Cases:**
- Form filling and submission
- E2E testing workflows
- Price monitoring
- Website health checks
- SEO audits
- Bulk operations

**Examples:**

```bash
# Form automation
/automate-task "Fill contact form with test data"

# E2E testing
/automate-task "Test complete checkout flow"

# Monitoring
/automate-task "Check competitor prices daily"

# Screenshot generation
/automate-task "Capture homepage in all viewport sizes"

# SEO audit
/automate-task "Run SEO audit on all pages in sitemap"
```

---

### 3. `/extract-data [url]` - Data Extraction

Extract structured data with custom schemas.

**Extraction Methods:**
- CSS selectors
- Pattern matching (regex)
- JSON-LD structured data
- Open Graph tags
- HTML tables
- Multi-page aggregation

**Examples:**

```bash
# CSS selector extraction
/extract-data https://example.com --selector ".item" --fields "name:.title,price:.price"

# Pattern extraction
/extract-data https://example.com/contact --patterns "email,phone,url"

# Table extraction
/extract-data https://example.com/data --table --output data.csv

# Structured data
/extract-data https://example.com/product --schema json-ld

# Custom schema
/extract-data https://example.com --schema-file product-schema.json
```

**Data Quality:**
- Automatic validation
- Deduplication
- Text normalization
- Error reporting

---

### 4. `/screenshot [url]` - Visual Capture

Capture screenshots and generate PDFs.

**Features:**
- Full page or viewport screenshots
- Responsive testing (multiple devices)
- Element-specific capture
- PDF generation
- Transparent backgrounds
- Custom regions

**Examples:**

```bash
# Basic screenshot
/screenshot https://example.com

# Responsive testing
/screenshot https://example.com --responsive --devices "mobile,tablet,desktop"

# Specific element
/screenshot https://example.com --selector ".main-content"

# PDF generation
/screenshot https://example.com --pdf --format A4

# High quality
/screenshot https://example.com --type jpeg --quality 100 --full-page

# Remove elements
/screenshot https://example.com --remove ".ad,.cookie-banner"
```

---

## 🤖 Agent

### Scraping Expert

Expert in web scraping strategies, anti-bot techniques, and data extraction.

**Expertise:**
- Scraping strategy design
- Anti-bot circumvention
- Performance optimization
- Error handling
- Data quality assurance
- Legal & ethical guidelines

**When to Use:**
- Designing complex scraping workflows
- Dealing with anti-bot protection
- Optimizing scraping performance
- Ensuring data quality
- Legal compliance questions

**Activation:**
```bash
/agent scraping-expert

# Then ask questions like:
# "How should I scrape this SPA website?"
# "What's the best strategy for this site with Cloudflare protection?"
# "How can I make my scraping more respectful and avoid detection?"
```

---

## 🎯 Use Cases

### 1. Competitive Intelligence

**Scenario:** Monitor competitor pricing and products

```bash
# Scrape competitor catalog
/scrape https://competitor.com/products --paginate --max-pages 20

# Extract pricing data
/extract-data https://competitor.com/products --fields "name,price,inStock"

# Generate comparison report
# Data is automatically saved and can be analyzed
```

**Automate:** Set up daily price checks with scheduled tasks

---

### 2. Lead Generation

**Scenario:** Extract contact information from directories

```bash
# Extract emails and phones
/extract-data https://directory.com/companies --patterns "email,phone"

# Extract with pagination
/scrape https://directory.com/search --paginate --fields "company,contact,website"

# Export to CRM-ready format
# Output as CSV for import
```

**Note:** Always respect privacy laws (GDPR, CCPA)

---

### 3. Content Aggregation

**Scenario:** Aggregate news articles or blog posts

```bash
# Scrape articles
/scrape https://news-site.com --selector ".article" --fields "title,date,author,content"

# Extract from RSS equivalent
/extract-data https://blog.com/archive --table

# Generate digest
# Compile into markdown report
```

---

### 4. E2E Testing

**Scenario:** Automated testing of user flows

```bash
# Test checkout flow
/automate-task "Test complete checkout: add to cart → checkout → payment → confirmation"

# Test form validation
/automate-task "Test signup form with valid and invalid inputs"

# Visual regression testing
/screenshot https://staging.mysite.com --compare-with production-baseline.png
```

---

### 5. SEO Monitoring

**Scenario:** Track SEO metrics across your site

```bash
# SEO audit
/automate-task "Run SEO audit on homepage: check meta tags, headings, images, links"

# Multi-page audit
/automate-task "Audit all pages in sitemap for SEO issues"

# Track rankings
/scrape https://google.com/search?q=my-keyword --extract-positions
```

---

### 6. Documentation

**Scenario:** Generate visual documentation

```bash
# Screenshot all states
/screenshot https://app.com/dashboard --multiple-states "default,loading,error"

# Generate PDF guides
/screenshot https://docs.myapp.com --pdf --full-page

# Responsive docs
/screenshot https://app.com --responsive --devices "all"
```

---

## 🛡️ Best Practices

### Legal & Ethical

✅ **Always Check:**
- robots.txt before scraping
- Terms of Service for scraping permission
- Data privacy laws (GDPR, CCPA)

✅ **Be Respectful:**
- Implement rate limiting (1-2 seconds between requests)
- Identify yourself with proper User-Agent
- Cache results to minimize requests
- Scrape during off-peak hours

✅ **Don't:**
- Scrape copyrighted content for commercial use
- Overload servers with rapid requests
- Ignore robots.txt or HTTP status codes
- Scrape personal data without permission

### Technical

✅ **Performance:**
- Block unnecessary resources (images, CSS for data scraping)
- Use parallel scraping with concurrency limits
- Implement caching
- Choose appropriate wait strategies

✅ **Reliability:**
- Implement retry logic with exponential backoff
- Validate data at extraction time
- Log errors for debugging
- Handle edge cases (empty pages, timeouts, etc.)

✅ **Stealth:**
- Use realistic User-Agents
- Add random delays between actions
- Rotate proxies if necessary
- Mimic human behavior (mouse movements, scrolling)

---

## 🔧 Configuration

### Environment Variables

```bash
# Optional: Proxy configuration
export SCRAPING_PROXY="http://proxy.example.com:8080"

# Optional: Credentials for authenticated scraping
export SITE_CREDENTIALS="username:password"

# Optional: Rate limiting
export SCRAPE_DELAY_MS="2000"  # 2 seconds between requests
```

### Custom Extraction Schemas

Create `schema.json`:
```json
{
  "type": "product",
  "fields": {
    "title": {
      "selector": "h1.product-name",
      "type": "text",
      "required": true
    },
    "price": {
      "selector": ".price",
      "type": "number",
      "pattern": "\\$([\\d,]+\\.?\\d*)",
      "transform": "parseFloat"
    },
    "images": {
      "selector": "img.product-image",
      "type": "array",
      "attribute": "src"
    }
  }
}
```

Use with:
```bash
/extract-data https://example.com/product --schema-file schema.json
```

---

## 🐛 Troubleshooting

### Issue: Captcha/Bot Detection

**Symptoms:** "Access denied" or captcha pages

**Solutions:**
1. Use stealth mode (automatically enabled)
2. Add random delays between actions
3. Rotate User-Agents
4. Use residential proxies
5. Reduce scraping frequency

```bash
# Scrape with extra stealth
/scrape https://example.com --stealth --delay-range 2000-5000
```

---

### Issue: JavaScript Content Not Loading

**Symptoms:** Empty results, missing data

**Solutions:**
1. Wait for specific selectors
2. Wait for network idle
3. Increase timeout

```bash
# Wait for content
/scrape https://spa-app.com --wait-for ".content-loaded" --timeout 30000
```

---

### Issue: Pagination Not Working

**Symptoms:** Only first page scraped

**Solutions:**
1. Verify pagination selector
2. Check for dynamic URLs
3. Use URL-based pagination if available

```bash
# URL-based pagination
/scrape https://example.com/page/{1..10}

# Button-based pagination
/scrape https://example.com --paginate "button.next"
```

---

### Issue: Slow Performance

**Symptoms:** Scraping takes too long

**Solutions:**
1. Block unnecessary resources
2. Use parallel scraping
3. Reduce wait times
4. Target API directly if available

```bash
# Fast mode (blocks images, CSS)
/scrape https://example.com --fast-mode

# Parallel scraping
/scrape https://example.com --pages 1-100 --parallel 5
```

---

## 📊 Examples

### Example 1: E-Commerce Product Catalog

```bash
# Scrape product listings
/scrape https://store.example.com/products \
  --selector ".product-card" \
  --fields "name:.title,price:.price,image:img@src,rating:.stars" \
  --paginate ".next-page" \
  --max-pages 20 \
  --output products.json

# Result: products.json with 200+ products
```

---

### Example 2: Job Listings Aggregator

```bash
# Extract job postings
/extract-data https://jobs.example.com \
  --schema-file job-schema.json \
  --paginate \
  --output jobs.csv

# Schema captures: title, company, location, salary, posted_date
```

---

### Example 3: News Article Monitor

```bash
# Monitor news site for new articles
/scrape https://news.example.com \
  --selector "article.news" \
  --fields "headline,date,author" \
  --filter "date:today" \
  --output today-news.json

# Schedule to run hourly
```

---

### Example 4: Visual Regression Testing

```bash
# Capture baseline
/screenshot https://myapp.com --full-page --output baseline.png

# After deployment, capture updated
/screenshot https://myapp.com --full-page --output updated.png

# Compare (diff highlighting differences)
/screenshot https://myapp.com --compare baseline.png updated.png --output diff.png
```

---

## 🚀 Advanced Usage

### Scraping with Authentication

```javascript
// The plugin handles this automatically:
/scrape https://members.example.com/dashboard \
  --login \
  --username "${USER}" \
  --password "${PASS}"
```

### API Interception

```javascript
// Intercept API calls instead of scraping HTML
/scrape https://example.com --intercept-api "/api/products"

// Much faster and cleaner data
```

### Scheduled Scraping

```bash
# Use with cron or task scheduler
0 */6 * * * /scrape https://competitor.com/prices --output daily-prices.json

# Plugin maintains history automatically
```

---

## 📈 Performance Tips

1. **Block Resources:** Images/CSS save 50-70% load time
2. **Parallel Scraping:** 5-10 concurrent requests (be respectful)
3. **Cache Results:** Avoid re-scraping unchanged pages
4. **Target APIs:** Direct API access is 10x faster than scraping HTML
5. **Incremental Scraping:** Only scrape new/changed content

---

## 🎓 Learning Resources

### Recommended Reading
- [Web Scraping Best Practices](https://www.scrapinghub.com/guides/)
- [Puppeteer Documentation](https://pptr.dev/)
- [robots.txt Specification](https://www.robotstxt.org/)

### Related Patterns
- **API Testing Plugin** - Test scraped API endpoints
- **Database Manager** - Store scraped data
- **Documentation Generator** - Document scraping workflows

---

## 📝 License

MIT

---

## 🤝 Contributing

Improve this plugin:
1. Add new extraction patterns
2. Improve anti-bot techniques
3. Add more output formats
4. Share scraping strategies

---

**Pattern Demonstrated:** Web Scraping, Browser Automation, Data Extraction, MCP Integration

🌐 **Start scraping responsibly today!**
