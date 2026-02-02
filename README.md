<h1 align="center">📰 Flutter News App</h1>

<p align="center">
  A modern Flutter application that displays <b>real-time news</b> using REST APIs with clean architecture and smooth UI.
</p>

<hr/>

<h2>🚀 Features</h2>
<ul>
  <li>🔥 <b>Breaking News Carousel</b> with auto-scroll animation</li>
  <li>📰 <b>Trending News List</b> fetched from live APIs</li>
  <li>🗂 <b>Category Section</b> (Business, Sports, Health, etc.)</li>
  <li>🌐 <b>In-App Article View</b> using WebView</li>
  <li>⚡ <b>Cached Images</b> for better performance</li>
  <li>📱 Clean & responsive UI</li>
</ul>

<hr/>

<h2>🛠 Tech Stack</h2>
<ul>
  <li><b>Flutter</b> & Dart</li>
  <li><b>REST APIs</b> (NewsAPI.org)</li>
  <li>HTTP Package</li>
  <li>Model-based Architecture</li>
  <li>Carousel Slider</li>
  <li>Cached Network Image</li>
  <li>WebView</li>
</ul>

<hr/>

<h2>📱 App Flow</h2>
<pre>
Launch App
   ↓
Home Screen
   ↓
Categories Section
   ↓
Breaking News Carousel
   ↓
Trending News List
   ↓
Tap Article → WebView
</pre>

<hr/>

<h2>🧠 How the App Works</h2>

<h3>1️⃣ API Integration</h3>
<p>
The app fetches news data using <b>GET requests</b> from NewsAPI.
The response is received in <b>JSON format</b> and parsed inside service classes.
</p>

<h3>2️⃣ Models</h3>
<p>
All API responses are converted into Dart models using <code>fromJson()</code>.
This keeps the UI clean and type-safe.
</p>

<h3>3️⃣ Service Layer</h3>
<p>
API calls are separated from UI logic to follow clean architecture principles.
</p>

<pre>
UI → Service → API → Model → UI
</pre>

<h3>4️⃣ UI Rendering</h3>
<ul>
  <li>ListView.builder for large data</li>
  <li>CarouselSlider for breaking news</li>
  <li>Future-based async loading</li>
  <li>Loading & error handling</li>
</ul>

<hr/>

<h2>📦 Dependencies Used</h2>

<pre>
http
carousel_slider
cached_network_image
smooth_page_indicator
webview_flutter
</pre>

<hr/>

<h2>📚 What I Learned</h2>
<ul>
  <li>How REST APIs work in real applications</li>
  <li>Fetching & parsing JSON data</li>
  <li>Why models are important</li>
  <li>Separating UI and business logic</li>
  <li>Handling null & API errors safely</li>
  <li>Building production-level Flutter apps</li>
</ul>

<hr/>

<h2>🧪 Challenges Solved</h2>
<ul>
  <li>Breaking news not loading → fixed async API handling</li>
  <li>Image crashes → added null checks</li>
  <li>UI not updating → proper state management</li>
  <li>Wrong API mapping → corrected models</li>
</ul>

<hr/>

<h2>🔮 Future Improvements</h2>
<ul>
  <li>🔍 Search news</li>
  <li>🗂 Category-wise filtering</li>
  <li>📄 Pagination (Load More)</li>
  <li>🔄 Pull-to-Refresh</li>
  <li>🌙 Dark / Light Theme</li>
  <li>💾 Offline caching</li>
</ul>

<hr/>

<h2>👨‍💻 Developer</h2>
<p>
<b>Shaurya Thakur</b><br/>
Flutter Developer | BCA Student<br/>
Himachal Pradesh University
</p>

<hr/>

<h3 align="center">⭐ If you like this project, don’t forget to star the repository!</h3>
