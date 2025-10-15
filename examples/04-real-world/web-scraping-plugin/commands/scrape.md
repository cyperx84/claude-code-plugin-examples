---
description: Scrape data from websites using Puppeteer browser automation
---

# Web Scraping Command

Scrape data from: $ARGUMENTS (URL and extraction instructions)

**Using Puppeteer MCP for browser automation**

## Scraping Capabilities

### 1. Static Content Extraction

**Simple Data:**
```javascript
// Navigate to page
await page.goto('https://example.com/products');

// Extract text content
const titles = await page.$$eval('h2.product-title',
  elements => elements.map(el => el.textContent.trim())
);

// Extract attributes
const prices = await page.$$eval('[data-price]',
  elements => elements.map(el => el.dataset.price)
);

// Extract links
const links = await page.$$eval('a.product-link',
  elements => elements.map(el => el.href)
);
```

**Structured Data:**
```javascript
// Extract product listings
const products = await page.$$eval('.product-card', cards => {
  return cards.map(card => ({
    title: card.querySelector('.title')?.textContent,
    price: card.querySelector('.price')?.textContent,
    image: card.querySelector('img')?.src,
    rating: card.querySelector('.rating')?.textContent,
    inStock: card.querySelector('.stock')?.textContent === 'In Stock'
  }));
});
```

### 2. Dynamic Content (JavaScript-Rendered)

**Wait for Content:**
```javascript
// Wait for dynamic content to load
await page.waitForSelector('.dynamic-content', { timeout: 10000 });

// Wait for network to be idle
await page.goto('https://spa-app.com', {
  waitUntil: 'networkidle0'
});

// Wait for specific condition
await page.waitForFunction(() => {
  return document.querySelectorAll('.item').length > 0;
});
```

**Infinite Scroll:**
```javascript
// Auto-scroll to load all content
await page.evaluate(async () => {
  await new Promise((resolve) => {
    let totalHeight = 0;
    const distance = 100;
    const timer = setInterval(() => {
      window.scrollBy(0, distance);
      totalHeight += distance;

      if (totalHeight >= document.body.scrollHeight) {
        clearInterval(timer);
        resolve();
      }
    }, 100);
  });
});

// Now extract all loaded items
const allItems = await page.$$eval('.item', items =>
  items.map(item => item.textContent)
);
```

### 3. Pagination Handling

**Next Button Pagination:**
```javascript
let allData = [];
let hasNextPage = true;

while (hasNextPage) {
  // Extract data from current page
  const pageData = await page.$$eval('.item', items =>
    items.map(item => ({
      title: item.querySelector('.title')?.textContent,
      link: item.querySelector('a')?.href
    }))
  );

  allData.push(...pageData);

  // Check if next button exists
  const nextButton = await page.$('.next-page');
  if (nextButton) {
    await nextButton.click();
    await page.waitForNavigation({ waitUntil: 'networkidle0' });
  } else {
    hasNextPage = false;
  }
}
```

**URL Parameter Pagination:**
```javascript
const baseUrl = 'https://example.com/products?page=';
const totalPages = 10;
let allProducts = [];

for (let page = 1; page <= totalPages; page++) {
  await page.goto(`${baseUrl}${page}`);

  const products = await page.$$eval('.product', items =>
    items.map(item => ({
      name: item.querySelector('.name')?.textContent,
      price: item.querySelector('.price')?.textContent
    }))
  );

  allProducts.push(...products);
}
```

### 4. Authentication & Forms

**Login Flow:**
```javascript
// Navigate to login page
await page.goto('https://example.com/login');

// Fill in credentials
await page.type('#username', process.env.SCRAPE_USERNAME);
await page.type('#password', process.env.SCRAPE_PASSWORD);

// Submit form
await Promise.all([
  page.click('button[type="submit"]'),
  page.waitForNavigation({ waitUntil: 'networkidle0' })
]);

// Now scrape authenticated content
const privateData = await page.$$eval('.private-content', items =>
  items.map(item => item.textContent)
);
```

**Form Interaction:**
```javascript
// Fill out search form
await page.select('#category', 'electronics');
await page.type('#search', 'laptop');
await page.click('#price-range-high');

// Submit and wait for results
await Promise.all([
  page.click('button.search'),
  page.waitForSelector('.results')
]);

// Extract results
const results = await page.$$eval('.result-item', items =>
  items.map(item => item.textContent)
);
```

### 5. API Interception

**Monitor Network Requests:**
```javascript
// Intercept API calls to get data directly
const apiData = [];

page.on('response', async (response) => {
  const url = response.url();

  // Capture API responses
  if (url.includes('/api/products')) {
    const data = await response.json();
    apiData.push(data);
  }
});

// Navigate to trigger API calls
await page.goto('https://example.com/products');

// Wait for API calls to complete
await page.waitForTimeout(3000);

// apiData now contains intercepted data
console.log('Captured API data:', apiData);
```

## Best Practices

### Rate Limiting
```javascript
// Add delays between requests
await page.waitForTimeout(1000); // 1 second delay

// Random delays for more natural behavior
const delay = Math.floor(Math.random() * 3000) + 1000;
await page.waitForTimeout(delay);
```

### User-Agent Rotation
```javascript
const userAgents = [
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
  'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36'
];

const randomUA = userAgents[Math.floor(Math.random() * userAgents.length)];
await page.setUserAgent(randomUA);
```

### Error Handling
```javascript
try {
  await page.goto(url, { timeout: 30000 });
} catch (error) {
  console.error(`Failed to load ${url}:`, error.message);
  // Retry logic
  await page.goto(url, { timeout: 30000, waitUntil: 'domcontentloaded' });
}
```

### Respecting robots.txt
```javascript
// Check robots.txt before scraping
const robotsUrl = new URL('/robots.txt', url).href;
const robotsResponse = await page.goto(robotsUrl);
const robotsText = await robotsResponse.text();

// Parse and respect disallow rules
if (robotsText.includes('Disallow: /api/')) {
  console.log('API scraping not allowed by robots.txt');
  return;
}
```

## Example Usage

```bash
# Scrape product listings
/scrape https://example.com/products --extract ".product-card" --output products.json

# Scrape with pagination
/scrape https://example.com/blog --paginate ".next" --max-pages 10

# Scrape with authentication
/scrape https://members.example.com/dashboard --login --credentials-env SITE_CREDS

# Scrape dynamic content
/scrape https://spa-app.com --wait-for ".content-loaded" --scroll

# Extract specific fields
/scrape https://news.com --fields "title:.headline,date:.pub-date,author:.author-name"
```

## Output Formats

**JSON:**
```json
{
  "url": "https://example.com/products",
  "timestamp": "2025-10-15T10:30:00Z",
  "data": [
    {
      "title": "Product 1",
      "price": "$29.99",
      "image": "https://example.com/images/product1.jpg"
    }
  ]
}
```

**CSV:**
```csv
title,price,image
"Product 1","$29.99","https://example.com/images/product1.jpg"
"Product 2","$39.99","https://example.com/images/product2.jpg"
```

**Markdown Table:**
```markdown
| Title | Price | Image |
|-------|-------|-------|
| Product 1 | $29.99 | [Link](https://example.com/images/product1.jpg) |
| Product 2 | $39.99 | [Link](https://example.com/images/product2.jpg) |
```

## Legal & Ethical Considerations

⚠️ **Important Guidelines:**
1. **Check Terms of Service** - Ensure scraping is allowed
2. **Respect robots.txt** - Honor website scraping policies
3. **Rate Limiting** - Don't overload servers
4. **Authentication** - Only scrape data you have permission to access
5. **Data Privacy** - Respect privacy laws (GDPR, CCPA)
6. **Attribution** - Credit data sources when required

**Pattern Demonstrated:** Browser Automation, Data Extraction, MCP Integration
