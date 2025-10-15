---
description: Automate repetitive browser tasks with Puppeteer
---

# Browser Task Automation

Automate browser task: $ARGUMENTS (task description)

**Using Puppeteer MCP for browser automation**

## Automation Scenarios

### 1. Form Filling & Submission

**Job Application Automation:**
```javascript
// Navigate to application page
await page.goto('https://careers.example.com/apply');

// Fill personal information
await page.type('#firstName', 'John');
await page.type('#lastName', 'Doe');
await page.type('#email', 'john.doe@example.com');
await page.type('#phone', '555-0123');

// Upload resume
const resumeInput = await page.$('#resume');
await resumeInput.uploadFile('/path/to/resume.pdf');

// Select dropdown options
await page.select('#experience', '5-10-years');
await page.select('#education', 'bachelors');

// Check boxes
await page.click('#terms-agreement');
await page.click('#subscribe-newsletter');

// Submit form
await Promise.all([
  page.click('button[type="submit"]'),
  page.waitForNavigation({ waitUntil: 'networkidle0' })
]);

// Verify submission
const confirmation = await page.$eval('.success-message',
  el => el.textContent
);
console.log('Application submitted:', confirmation);
```

**Bulk Data Entry:**
```javascript
const entries = [
  { name: 'Item 1', quantity: 10, price: 29.99 },
  { name: 'Item 2', quantity: 5, price: 49.99 },
  // ... more entries
];

for (const entry of entries) {
  await page.click('.add-new-item');

  await page.type('#item-name', entry.name);
  await page.type('#quantity', entry.quantity.toString());
  await page.type('#price', entry.price.toString());

  await page.click('.save-item');
  await page.waitForSelector('.item-saved');

  // Small delay between entries
  await page.waitForTimeout(500);
}
```

### 2. Testing & Validation

**E2E User Flow Testing:**
```javascript
// Test complete checkout flow
async function testCheckoutFlow() {
  // 1. Browse products
  await page.goto('https://store.example.com');
  await page.waitForSelector('.product-grid');

  // 2. Add items to cart
  await page.click('.product-card:first-child .add-to-cart');
  await page.waitForSelector('.cart-count');

  // 3. View cart
  await page.click('.cart-icon');
  await page.waitForSelector('.cart-page');

  // 4. Proceed to checkout
  await page.click('.checkout-button');
  await page.waitForSelector('.checkout-form');

  // 5. Fill shipping info
  await page.type('#address', '123 Main St');
  await page.type('#city', 'Springfield');
  await page.type('#zip', '12345');

  // 6. Select payment method
  await page.click('#payment-credit-card');
  await page.type('#card-number', '4111111111111111');
  await page.type('#cvv', '123');

  // 7. Place order
  await Promise.all([
    page.click('.place-order'),
    page.waitForSelector('.order-confirmation')
  ]);

  // 8. Verify order placed
  const orderNumber = await page.$eval('.order-number',
    el => el.textContent
  );

  console.log('✅ Order placed successfully:', orderNumber);
  return { success: true, orderNumber };
}
```

**Form Validation Testing:**
```javascript
// Test form validation rules
const testCases = [
  { email: '', expected: 'Email is required' },
  { email: 'invalid', expected: 'Invalid email format' },
  { email: 'valid@example.com', expected: null }
];

for (const test of testCases) {
  await page.fill('#email', test.email);
  await page.click('button[type="submit"]');

  const error = await page.$eval('.error-message',
    el => el.textContent
  ).catch(() => null);

  if (error === test.expected) {
    console.log(`✅ Test passed: "${test.email}"`);
  } else {
    console.log(`❌ Test failed: expected "${test.expected}", got "${error}"`);
  }
}
```

### 3. Monitoring & Alerting

**Price Monitoring:**
```javascript
// Monitor product price changes
async function monitorPrice(url, targetPrice) {
  await page.goto(url);

  const currentPrice = await page.$eval('.price',
    el => parseFloat(el.textContent.replace(/[^0-9.]/g, ''))
  );

  console.log(`Current price: $${currentPrice}`);

  if (currentPrice <= targetPrice) {
    // Send alert (could integrate with Slack, email, etc.)
    console.log(`🚨 ALERT: Price dropped to $${currentPrice}!`);
    return { alert: true, price: currentPrice };
  }

  return { alert: false, price: currentPrice };
}

// Run every hour
setInterval(() => {
  monitorPrice('https://store.com/product', 199.99);
}, 3600000);
```

**Website Uptime Monitoring:**
```javascript
async function checkWebsiteHealth(url) {
  try {
    const startTime = Date.now();
    await page.goto(url, { timeout: 10000 });
    const loadTime = Date.now() - startTime;

    // Check for error messages
    const hasError = await page.$('.error-page') !== null;

    if (hasError) {
      console.log('❌ Website showing error page');
      return { status: 'error', loadTime };
    }

    // Check critical elements
    const hasCriticalElement = await page.$('.main-content') !== null;

    if (!hasCriticalElement) {
      console.log('⚠️ Critical element missing');
      return { status: 'degraded', loadTime };
    }

    console.log(`✅ Website healthy (${loadTime}ms)`);
    return { status: 'healthy', loadTime };

  } catch (error) {
    console.log('❌ Website unreachable:', error.message);
    return { status: 'down', error: error.message };
  }
}
```

### 4. Data Collection & Reporting

**Competitor Analysis:**
```javascript
async function analyzeCompetitor(url) {
  await page.goto(url);

  // Collect pricing data
  const prices = await page.$$eval('.product-price',
    elements => elements.map(el => parseFloat(el.textContent.replace(/[^0-9.]/g, '')))
  );

  // Collect product features
  const features = await page.$$eval('.feature-list li',
    elements => elements.map(el => el.textContent)
  );

  // Check shipping options
  const shippingInfo = await page.$eval('.shipping',
    el => el.textContent
  ).catch(() => 'Not available');

  // Analyze marketing messaging
  const headlines = await page.$$eval('h1, h2.hero',
    elements => elements.map(el => el.textContent)
  );

  return {
    url,
    priceRange: {
      min: Math.min(...prices),
      max: Math.max(...prices),
      avg: prices.reduce((a, b) => a + b, 0) / prices.length
    },
    features,
    shipping: shippingInfo,
    messaging: headlines
  };
}
```

**SEO Audit Automation:**
```javascript
async function auditSEO(url) {
  await page.goto(url);

  // Check meta tags
  const title = await page.$eval('title', el => el.textContent)
    .catch(() => null);
  const description = await page.$eval('meta[name="description"]',
    el => el.content
  ).catch(() => null);

  // Check heading structure
  const h1Count = await page.$$eval('h1', els => els.length);
  const h2Count = await page.$$eval('h2', els => els.length);

  // Check images alt text
  const imagesWithoutAlt = await page.$$eval('img:not([alt])',
    els => els.length
  );

  // Check internal links
  const internalLinks = await page.$$eval('a[href^="/"]',
    els => els.length
  );

  // Check page load performance
  const metrics = await page.metrics();

  return {
    meta: {
      title: title || '❌ Missing',
      titleLength: title?.length || 0,
      description: description || '❌ Missing',
      descriptionLength: description?.length || 0
    },
    headings: {
      h1Count,
      h1Warning: h1Count !== 1 ? '⚠️ Should have exactly 1 H1' : '✅'
    },
    images: {
      missingAlt: imagesWithoutAlt,
      warning: imagesWithoutAlt > 0 ? `⚠️ ${imagesWithoutAlt} images without alt` : '✅'
    },
    links: {
      internal: internalLinks
    },
    performance: {
      jsHeapUsed: Math.round(metrics.JSHeapUsedSize / 1024 / 1024) + 'MB',
      nodes: metrics.Nodes
    }
  };
}
```

### 5. Screenshot & PDF Generation

**Automated Screenshots:**
```javascript
// Capture different viewport sizes
const viewports = [
  { name: 'mobile', width: 375, height: 812 },
  { name: 'tablet', width: 768, height: 1024 },
  { name: 'desktop', width: 1920, height: 1080 }
];

for (const viewport of viewports) {
  await page.setViewport({
    width: viewport.width,
    height: viewport.height
  });

  await page.goto('https://example.com');

  await page.screenshot({
    path: `screenshot-${viewport.name}.png`,
    fullPage: true
  });
}
```

**PDF Generation:**
```javascript
// Generate PDF reports
await page.goto('https://example.com/report');

await page.pdf({
  path: 'report.pdf',
  format: 'A4',
  printBackground: true,
  margin: {
    top: '1cm',
    right: '1cm',
    bottom: '1cm',
    left: '1cm'
  }
});
```

## Example Usage

```bash
# Automate form filling
/automate-task "Fill out contact form on https://example.com/contact with test data"

# Run E2E tests
/automate-task "Test checkout flow on staging environment"

# Monitor prices
/automate-task "Check prices on competitor websites and alert if lower than $99"

# Generate screenshots
/automate-task "Capture screenshots of homepage in mobile, tablet, desktop sizes"

# SEO audit
/automate-task "Run SEO audit on all pages in sitemap"

# Bulk operations
/automate-task "Submit 100 test entries to form from CSV file"
```

## Scheduling Automation

**Cron-like Scheduling:**
```javascript
// Run daily at 9 AM
schedule('0 9 * * *', async () => {
  await automateTask('Daily competitor price check');
});

// Run every 5 minutes
schedule('*/5 * * * *', async () => {
  await automateTask('Website health check');
});

// Run every Monday at 8 AM
schedule('0 8 * * 1', async () => {
  await automateTask('Weekly SEO audit report');
});
```

## Error Recovery

**Retry Logic:**
```javascript
async function automateWithRetry(task, maxRetries = 3) {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      await task();
      return { success: true };
    } catch (error) {
      console.log(`Attempt ${attempt} failed:`, error.message);

      if (attempt === maxRetries) {
        return { success: false, error: error.message };
      }

      // Exponential backoff
      await page.waitForTimeout(1000 * Math.pow(2, attempt));
    }
  }
}
```

**Pattern Demonstrated:** Browser Automation, Task Scheduling, Error Recovery
