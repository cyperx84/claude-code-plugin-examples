---
description: Extract structured data from web pages using CSS selectors and patterns
---

# Data Extraction Command

Extract data from: $ARGUMENTS (URL and data schema)

**Using Puppeteer MCP for intelligent data extraction**

## Extraction Strategies

### 1. CSS Selector Extraction

**Basic Selectors:**
```javascript
// Extract by class
const titles = await page.$$eval('.title', els =>
  els.map(el => el.textContent.trim())
);

// Extract by ID
const mainHeading = await page.$eval('#main-heading',
  el => el.textContent
);

// Extract by attribute
const dataItems = await page.$$eval('[data-item-id]', els =>
  els.map(el => ({
    id: el.dataset.itemId,
    text: el.textContent
  }))
);

// Complex selectors
const productData = await page.$$eval(
  'div.product-grid > div.product-card:not(.sponsored)',
  cards => cards.map(card => ({
    name: card.querySelector('.name')?.textContent,
    price: card.querySelector('.price')?.textContent,
    rating: card.querySelector('.rating')?.textContent
  }))
);
```

### 2. Pattern-Based Extraction

**Email Addresses:**
```javascript
const pageText = await page.evaluate(() => document.body.innerText);
const emailPattern = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/g;
const emails = pageText.match(emailPattern) || [];

console.log('Found emails:', emails);
```

**Phone Numbers:**
```javascript
const phonePattern = /\b(\+\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\b/g;
const phones = pageText.match(phonePattern) || [];

console.log('Found phone numbers:', phones);
```

**URLs:**
```javascript
const urlPattern = /(https?:\/\/[^\s]+)/g;
const urls = pageText.match(urlPattern) || [];

console.log('Found URLs:', urls);
```

**Prices:**
```javascript
const pricePattern = /\$\d+(?:,\d{3})*(?:\.\d{2})?/g;
const prices = pageText.match(pricePattern) || [];

console.log('Found prices:', prices);
```

### 3. Structured Data Extraction (JSON-LD, Microdata)

**JSON-LD Schema:**
```javascript
// Extract structured data from JSON-LD scripts
const structuredData = await page.evaluate(() => {
  const scripts = Array.from(
    document.querySelectorAll('script[type="application/ld+json"]')
  );

  return scripts.map(script => {
    try {
      return JSON.parse(script.textContent);
    } catch {
      return null;
    }
  }).filter(Boolean);
});

// Extract product info from schema
const product = structuredData.find(data => data['@type'] === 'Product');
if (product) {
  console.log({
    name: product.name,
    price: product.offers?.price,
    rating: product.aggregateRating?.ratingValue,
    description: product.description
  });
}
```

**Open Graph Tags:**
```javascript
const ogData = await page.evaluate(() => {
  const metas = Array.from(document.querySelectorAll('meta[property^="og:"]'));

  return metas.reduce((acc, meta) => {
    const property = meta.getAttribute('property').replace('og:', '');
    const content = meta.getAttribute('content');
    acc[property] = content;
    return acc;
  }, {});
});

console.log('Open Graph data:', ogData);
// { title: 'Page Title', image: 'image.jpg', description: '...' }
```

### 4. Table Data Extraction

**HTML Tables to JSON:**
```javascript
const tableData = await page.evaluate(() => {
  const table = document.querySelector('table');
  if (!table) return null;

  // Extract headers
  const headers = Array.from(table.querySelectorAll('thead th'))
    .map(th => th.textContent.trim());

  // Extract rows
  const rows = Array.from(table.querySelectorAll('tbody tr'))
    .map(tr => {
      const cells = Array.from(tr.querySelectorAll('td'))
        .map(td => td.textContent.trim());

      // Create object with headers as keys
      return headers.reduce((obj, header, index) => {
        obj[header] = cells[index];
        return obj;
      }, {});
    });

  return rows;
});

console.log('Table data:', tableData);
```

### 5. Multi-Page Data Aggregation

**Aggregate from Multiple Pages:**
```javascript
async function extractFromMultiplePages(urls) {
  const allData = [];

  for (const url of urls) {
    await page.goto(url, { waitUntil: 'networkidle0' });

    const pageData = await page.evaluate(() => {
      return Array.from(document.querySelectorAll('.item')).map(item => ({
        title: item.querySelector('.title')?.textContent,
        description: item.querySelector('.desc')?.textContent,
        link: item.querySelector('a')?.href
      }));
    });

    allData.push({
      url,
      data: pageData,
      extractedAt: new Date().toISOString()
    });

    // Polite delay
    await page.waitForTimeout(1000);
  }

  return allData;
}
```

### 6. Image & Media Extraction

**Extract Images:**
```javascript
const images = await page.evaluate(() => {
  const imgs = Array.from(document.querySelectorAll('img'));

  return imgs.map(img => ({
    src: img.src,
    alt: img.alt,
    width: img.naturalWidth,
    height: img.naturalHeight,
    isLazy: img.loading === 'lazy'
  }));
});

// Download images
for (const img of images) {
  // Use viewSource or download logic here
  console.log('Image:', img.src);
}
```

**Extract Videos:**
```javascript
const videos = await page.evaluate(() => {
  const vids = Array.from(document.querySelectorAll('video'));

  return vids.map(video => ({
    src: video.src || video.querySelector('source')?.src,
    poster: video.poster,
    duration: video.duration,
    type: video.querySelector('source')?.type
  }));
});
```

### 7. Dynamic Content Extraction

**Wait for AJAX Content:**
```javascript
// Wait for specific content to load
await page.waitForFunction(
  () => document.querySelectorAll('.loaded-item').length > 0,
  { timeout: 10000 }
);

// Extract after content loads
const dynamicData = await page.$$eval('.loaded-item', items =>
  items.map(item => item.textContent)
);
```

**Intercept API Calls:**
```javascript
const apiData = [];

// Listen for API responses
page.on('response', async response => {
  const url = response.url();

  if (url.includes('/api/data')) {
    try {
      const json = await response.json();
      apiData.push(json);
    } catch {}
  }
});

// Trigger page load
await page.goto('https://example.com');

// Wait for API calls
await page.waitForTimeout(3000);

console.log('Extracted from API:', apiData);
```

### 8. Text Cleaning & Normalization

**Clean Extracted Text:**
```javascript
function cleanText(text) {
  return text
    .replace(/\s+/g, ' ')           // Normalize whitespace
    .replace(/\n+/g, '\n')          // Normalize newlines
    .replace(/&nbsp;/g, ' ')        // Replace nbsp
    .replace(/&amp;/g, '&')         // Decode entities
    .trim();                         // Trim edges
}

const cleanedData = rawData.map(item => ({
  ...item,
  text: cleanText(item.text)
}));
```

**Extract Numbers:**
```javascript
function extractNumber(text) {
  const match = text.match(/[\d,]+\.?\d*/);
  return match ? parseFloat(match[0].replace(/,/g, '')) : null;
}

const price = extractNumber('$1,234.56'); // 1234.56
const rating = extractNumber('4.5 stars');  // 4.5
```

## Data Schema Definitions

**Define Extraction Schema:**
```javascript
const schema = {
  type: 'product',
  fields: {
    title: {
      selector: 'h1.product-title',
      type: 'text',
      required: true
    },
    price: {
      selector: '.price',
      type: 'number',
      pattern: /\$?([\d,]+\.?\d*)/,
      transform: text => parseFloat(text.replace(/[$,]/g, ''))
    },
    images: {
      selector: 'img.product-image',
      type: 'array',
      attribute: 'src'
    },
    inStock: {
      selector: '.availability',
      type: 'boolean',
      transform: text => text.toLowerCase().includes('in stock')
    },
    reviews: {
      selector: '.review',
      type: 'nested',
      fields: {
        author: { selector: '.author', type: 'text' },
        rating: { selector: '.rating', type: 'number' },
        text: { selector: '.review-text', type: 'text' }
      }
    }
  }
};

// Apply schema to extract data
const extracted = await extractWithSchema(page, schema);
```

## Export Formats

### JSON
```json
{
  "extractedAt": "2025-10-15T10:30:00Z",
  "url": "https://example.com/products",
  "data": [
    {
      "id": "prod-1",
      "title": "Product Name",
      "price": 29.99,
      "inStock": true
    }
  ]
}
```

### CSV
```csv
id,title,price,inStock
prod-1,"Product Name",29.99,true
prod-2,"Another Product",39.99,false
```

### Excel
```javascript
// Generate Excel with formatting
const workbook = new ExcelJS.Workbook();
const worksheet = workbook.addWorksheet('Extracted Data');

worksheet.columns = [
  { header: 'ID', key: 'id', width: 10 },
  { header: 'Title', key: 'title', width: 30 },
  { header: 'Price', key: 'price', width: 10 }
];

data.forEach(item => worksheet.addRow(item));

await workbook.xlsx.writeFile('data.xlsx');
```

### Database Insert
```javascript
// Insert into database
for (const item of extractedData) {
  await db.insert('products', {
    title: item.title,
    price: item.price,
    extracted_at: new Date()
  });
}
```

## Example Usage

```bash
# Extract with CSS selectors
/extract-data https://example.com/products --selector ".product-card" --fields "title:.name,price:.price"

# Extract emails and phones
/extract-data https://example.com/contact --patterns "email,phone"

# Extract structured data
/extract-data https://example.com/product/123 --schema json-ld

# Extract table data
/extract-data https://example.com/data --table --output table.csv

# Multi-page extraction
/extract-data https://example.com/page --paginate --max-pages 10 --output data.json

# Extract with custom schema
/extract-data https://example.com --schema-file product-schema.json --output products.json
```

## Quality Validation

**Data Validation:**
```javascript
function validateExtraction(data, schema) {
  const errors = [];

  // Check required fields
  for (const field of schema.required) {
    if (!data[field]) {
      errors.push(`Missing required field: ${field}`);
    }
  }

  // Check data types
  for (const [field, value] of Object.entries(data)) {
    const expectedType = schema.fields[field]?.type;
    const actualType = typeof value;

    if (expectedType && actualType !== expectedType) {
      errors.push(`Field ${field}: expected ${expectedType}, got ${actualType}`);
    }
  }

  return {
    valid: errors.length === 0,
    errors
  };
}
```

**Pattern Demonstrated:** Data Extraction, Schema Validation, Multi-Format Export
