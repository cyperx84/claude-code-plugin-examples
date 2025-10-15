---
description: Capture screenshots and generate PDFs of web pages
---

# Screenshot & PDF Command

Capture screenshot of: $ARGUMENTS (URL and options)

**Using Puppeteer MCP for visual capture**

## Screenshot Capabilities

### 1. Basic Screenshots

**Full Page:**
```javascript
await page.goto('https://example.com');

await page.screenshot({
  path: 'fullpage.png',
  fullPage: true  // Capture entire scrollable page
});
```

**Viewport Only:**
```javascript
await page.screenshot({
  path: 'viewport.png',
  fullPage: false  // Only visible area
});
```

**Specific Element:**
```javascript
const element = await page.$('.main-content');

await element.screenshot({
  path: 'element.png'
});
```

### 2. Responsive Screenshots

**Multiple Viewports:**
```javascript
const devices = [
  { name: 'iPhone 12', width: 390, height: 844 },
  { name: 'iPad Pro', width: 1024, height: 1366 },
  { name: 'Desktop HD', width: 1920, height: 1080 },
  { name: 'Desktop 4K', width: 3840, height: 2160 }
];

for (const device of devices) {
  await page.setViewport({
    width: device.width,
    height: device.height,
    deviceScaleFactor: device.width > 2000 ? 2 : 1
  });

  await page.goto('https://example.com');

  await page.screenshot({
    path: `screenshot-${device.name}.png`,
    fullPage: true
  });
}
```

**Emulate Real Devices:**
```javascript
const puppeteer = require('puppeteer');
const devices = puppeteer.devices;

// Use predefined device
await page.emulate(devices['iPhone 12 Pro']);
await page.goto('https://example.com');
await page.screenshot({ path: 'iphone12.png', fullPage: true });

// iPad
await page.emulate(devices['iPad Pro']);
await page.goto('https://example.com');
await page.screenshot({ path: 'ipad.png', fullPage: true });
```

### 3. Advanced Screenshot Options

**High Quality:**
```javascript
await page.screenshot({
  path: 'high-quality.png',
  type: 'png',           // 'png' or 'jpeg'
  quality: 100,          // For jpeg: 0-100
  omitBackground: false, // Include page background
  fullPage: true
});
```

**Transparent Background:**
```javascript
await page.screenshot({
  path: 'transparent.png',
  omitBackground: true,  // Make background transparent
  type: 'png'            // Must be PNG for transparency
});
```

**Custom Clip Region:**
```javascript
await page.screenshot({
  path: 'region.png',
  clip: {
    x: 100,      // X coordinate
    y: 100,      // Y coordinate
    width: 800,  // Width
    height: 600  // Height
  }
});
```

**Base64 Encoding:**
```javascript
const screenshot = await page.screenshot({
  encoding: 'base64',
  fullPage: true
});

// Use in HTML
const html = `<img src="data:image/png;base64,${screenshot}" />`;
```

### 4. PDF Generation

**Basic PDF:**
```javascript
await page.goto('https://example.com');

await page.pdf({
  path: 'document.pdf',
  format: 'A4',           // Paper format
  printBackground: true   // Include backgrounds
});
```

**Custom Page Size:**
```javascript
await page.pdf({
  path: 'custom.pdf',
  width: '8.5in',
  height: '11in',
  printBackground: true,
  margin: {
    top: '1in',
    right: '0.5in',
    bottom: '1in',
    left: '0.5in'
  }
});
```

**Landscape PDF:**
```javascript
await page.pdf({
  path: 'landscape.pdf',
  format: 'A4',
  landscape: true,
  printBackground: true
});
```

**Multi-Page PDF:**
```javascript
// Generate header/footer for each page
await page.pdf({
  path: 'report.pdf',
  format: 'A4',
  printBackground: true,
  displayHeaderFooter: true,
  headerTemplate: '<div style="font-size:10px; text-align:center; width:100%;">Company Report</div>',
  footerTemplate: '<div style="font-size:10px; text-align:center; width:100%;"><span class="pageNumber"></span> / <span class="totalPages"></span></div>',
  margin: {
    top: '100px',    // Space for header
    bottom: '100px'  // Space for footer
  }
});
```

### 5. Before Screenshot Actions

**Wait for Content:**
```javascript
await page.goto('https://example.com');

// Wait for specific element
await page.waitForSelector('.main-content', { timeout: 10000 });

// Wait for images to load
await page.waitForFunction(() => {
  const images = Array.from(document.images);
  return images.every(img => img.complete);
});

await page.screenshot({ path: 'ready.png', fullPage: true });
```

**Remove Elements:**
```javascript
// Remove unwanted elements before screenshot
await page.evaluate(() => {
  // Remove cookie banners
  document.querySelector('.cookie-banner')?.remove();

  // Remove chat widgets
  document.querySelector('#chat-widget')?.remove();

  // Remove ads
  document.querySelectorAll('.ad, .advertisement').forEach(ad => ad.remove());
});

await page.screenshot({ path: 'clean.png', fullPage: true });
```

**Scroll to Element:**
```javascript
const element = await page.$('.target-section');

await element.scrollIntoView();
await page.waitForTimeout(500); // Wait for scroll animation

await element.screenshot({ path: 'section.png' });
```

**Hover Effects:**
```javascript
// Trigger hover state
await page.hover('.button');
await page.waitForTimeout(500); // Wait for CSS transition

await page.screenshot({ path: 'hover-state.png' });
```

### 6. Comparison Screenshots

**Visual Regression Testing:**
```javascript
// Baseline screenshot
await page.goto('https://example.com');
await page.screenshot({ path: 'baseline.png', fullPage: true });

// After changes
await page.goto('https://staging.example.com');
await page.screenshot({ path: 'updated.png', fullPage: true });

// Compare (using pixelmatch or similar)
const diff = compareImages('baseline.png', 'updated.png');
console.log(`Diff: ${diff.percentage}% different`);
```

**Before/After States:**
```javascript
// Before state
await page.screenshot({ path: 'before.png' });

// Trigger action
await page.click('.toggle-button');
await page.waitForSelector('.expanded-content');

// After state
await page.screenshot({ path: 'after.png' });
```

### 7. Automated Screenshot Reports

**Generate Visual Report:**
```javascript
async function generateVisualReport(pages) {
  const report = [];

  for (const [name, url] of Object.entries(pages)) {
    await page.goto(url);
    await page.waitForLoadState('networkidle');

    const screenshot = await page.screenshot({
      fullPage: true,
      encoding: 'base64'
    });

    report.push({
      name,
      url,
      screenshot: `data:image/png;base64,${screenshot}`,
      timestamp: new Date().toISOString()
    });
  }

  // Generate HTML report
  const html = `
    <!DOCTYPE html>
    <html>
      <head>
        <title>Screenshot Report</title>
        <style>
          body { font-family: Arial; }
          .page { margin: 20px; border: 1px solid #ccc; padding: 10px; }
          img { max-width: 800px; border: 1px solid #ddd; }
        </style>
      </head>
      <body>
        <h1>Screenshot Report</h1>
        ${report.map(item => `
          <div class="page">
            <h2>${item.name}</h2>
            <p><a href="${item.url}">${item.url}</a></p>
            <p><small>${item.timestamp}</small></p>
            <img src="${item.screenshot}" />
          </div>
        `).join('')}
      </body>
    </html>
  `;

  await fs.writeFile('report.html', html);
  return report;
}

await generateVisualReport({
  'Homepage': 'https://example.com',
  'Product Page': 'https://example.com/products',
  'Contact': 'https://example.com/contact'
});
```

### 8. Screenshot Optimization

**Compress Images:**
```javascript
const sharp = require('sharp');

// Take screenshot
await page.screenshot({ path: 'original.png', fullPage: true });

// Optimize with sharp
await sharp('original.png')
  .resize(1920, null, { withoutEnlargement: true })
  .png({ quality: 80, compressionLevel: 9 })
  .toFile('optimized.png');
```

**Lazy Screenshots:**
```javascript
// Only screenshot if changed
const hash = await page.evaluate(() => {
  return document.body.innerText.split('').reduce((a, b) => {
    a = ((a << 5) - a) + b.charCodeAt(0);
    return a & a;
  }, 0);
});

if (hash !== previousHash) {
  await page.screenshot({ path: `screenshot-${hash}.png` });
  previousHash = hash;
}
```

## Example Usage

```bash
# Basic screenshot
/screenshot https://example.com

# Full page screenshot
/screenshot https://example.com --full-page

# Multiple viewports
/screenshot https://example.com --responsive --devices "mobile,tablet,desktop"

# Specific element
/screenshot https://example.com --selector ".main-content"

# Generate PDF
/screenshot https://example.com --pdf --format A4

# High quality JPEG
/screenshot https://example.com --type jpeg --quality 100

# Remove elements before capture
/screenshot https://example.com --remove ".ad,.cookie-banner"

# With custom viewport
/screenshot https://example.com --viewport 1920x1080

# Visual comparison
/screenshot https://example.com --compare-with baseline.png --output diff.png
```

## Use Cases

### 1. Visual Testing
- Regression testing after code changes
- Cross-browser screenshot comparison
- Responsive design validation

### 2. Documentation
- Generate visual documentation
- Create user guides with screenshots
- Document UI states

### 3. Monitoring
- Monitor website visual changes
- Alert on unexpected UI changes
- Track competitor websites

### 4. Archival
- Archive web pages visually
- Create historical records
- Preserve time-sensitive content

### 5. Reporting
- Generate visual reports
- Client presentations
- Bug reports with screenshots

**Pattern Demonstrated:** Visual Testing, Documentation Automation, Monitoring
