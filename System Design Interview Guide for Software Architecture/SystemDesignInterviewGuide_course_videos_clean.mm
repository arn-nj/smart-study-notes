<?xml version="1.0" encoding="UTF-8"?>
<map version="1.0.1">
  <node TEXT="System Design Interview Guide">
    <node TEXT="Page 1 - Introduction to the System Design Interview Series">
      <node TEXT="What You'll Learn">
        <node TEXT="Use a repeatable system design framework in interviews"/>
      </node>
      <node TEXT="Core Idea">
        <node TEXT="Common questions plus core topics drive preparation"/>
        <node TEXT="Patterns and trade-offs matter more than memorized diagrams"/>
      </node>
      <node TEXT="Visual Summary">
        <node TEXT="Clarify -&gt; Scope -&gt; Components -&gt; Trade-offs"/>
      </node>
      <node TEXT="Real-World Use">
        <node TEXT="Framework prevents freezing in broad design interviews"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="Functional requirements"/>
        <node TEXT="Non-functional requirements"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="First design step: clarify requirements and scale"/>
      </node>
      <node TEXT="Spaced Repetition">
        <node TEXT="Rehearse the 4-step answer structure"/>
      </node>
      <node TEXT="One-Page Revision">
        <node TEXT="Start with clarity, not components"/>
      </node>
    </node>
    <node TEXT="Page 2 - Choosing the Right Database">
      <node TEXT="What You'll Learn">
        <node TEXT="Match data shape, queries, and scale to the right database"/>
      </node>
      <node TEXT="Core Idea">
        <node TEXT="Database choice affects non-functional requirements heavily"/>
      </node>
      <node TEXT="Visual Summary">
        <node TEXT="RDBMS for ACID"/>
        <node TEXT="Document DB for flexible schema"/>
        <node TEXT="Columnar DB for massive append-heavy data"/>
        <node TEXT="Search engine for text"/>
      </node>
      <node TEXT="Real-World Use">
        <node TEXT="Amazon, Uber, and monitoring tools need different stores"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="Redis for caching"/>
        <node TEXT="S3 plus CDN for blob storage"/>
        <node TEXT="Elasticsearch or Solr for search"/>
        <node TEXT="OpenTSDB or InfluxDB for metrics"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="ACID money transfer needs relational DB"/>
      </node>
      <node TEXT="Spaced Repetition">
        <node TEXT="Rebuild the database decision tree"/>
      </node>
      <node TEXT="One-Page Revision">
        <node TEXT="Real systems often combine multiple databases"/>
      </node>
    </node>
    <node TEXT="Page 3 - URL Shortener System Design">
      <node TEXT="What You'll Learn">
        <node TEXT="Design low-latency shorten plus redirect flow"/>
      </node>
      <node TEXT="Core Idea">
        <node TEXT="Unique token generation is the main challenge"/>
      </node>
      <node TEXT="Visual Summary">
        <node TEXT="Token service gives ranges to instances"/>
        <node TEXT="Mappings stored in Cassandra"/>
        <node TEXT="Analytics flows to Kafka"/>
      </node>
      <node TEXT="Real-World Use">
        <node TEXT="Social apps need fast, always-available short links"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="Base62 character space"/>
        <node TEXT="Collision avoidance"/>
        <node TEXT="Asynchronous analytics"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Range allocation avoids duplicate short codes"/>
      </node>
      <node TEXT="Spaced Repetition">
        <node TEXT="Re-explain token service vs Redis counter"/>
      </node>
      <node TEXT="One-Page Revision">
        <node TEXT="Keep redirect path lean"/>
      </node>
    </node>
    <node TEXT="Page 4 - Hotel Booking System Design">
      <node TEXT="What You'll Learn">
        <node TEXT="Combine search, booking, TTL holds, and archival"/>
      </node>
      <node TEXT="Core Idea">
        <node TEXT="Booking correctness needs transactions"/>
      </node>
      <node TEXT="Visual Summary">
        <node TEXT="Hotel metadata in MySQL"/>
        <node TEXT="Search via Elasticsearch"/>
        <node TEXT="Booking TTL via Redis"/>
        <node TEXT="Archive to Cassandra"/>
      </node>
      <node TEXT="Real-World Use">
        <node TEXT="Last-room booking races need strong consistency"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="Available rooms table"/>
        <node TEXT="Reservation expiry"/>
        <node TEXT="Booking archive"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="MySQL protects room inventory changes"/>
      </node>
      <node TEXT="Spaced Repetition">
        <node TEXT="Rebuild reserved -&gt; booked -&gt; cancelled flow"/>
      </node>
      <node TEXT="One-Page Revision">
        <node TEXT="Search and booking use different storage strategies"/>
      </node>
    </node>
    <node TEXT="Page 5 - Amazon-Style E-commerce System Design">
      <node TEXT="What You'll Learn">
        <node TEXT="Separate catalog, search, order, inventory, and recommendations"/>
      </node>
      <node TEXT="Core Idea">
        <node TEXT="Search availability and order consistency need different designs"/>
      </node>
      <node TEXT="Visual Summary">
        <node TEXT="Catalog in MongoDB"/>
        <node TEXT="Search in Elasticsearch"/>
        <node TEXT="Orders in MySQL"/>
        <node TEXT="Historical orders in Cassandra"/>
      </node>
      <node TEXT="Real-World Use">
        <node TEXT="User search plus low stock checkout requires service split"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="Serviceability and TAT"/>
        <node TEXT="Inventory locking"/>
        <node TEXT="Order archival"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Kafka connects ingestion, orders, analytics, recommendations"/>
      </node>
      <node TEXT="Spaced Repetition">
        <node TEXT="Compare search consistency vs order consistency"/>
      </node>
      <node TEXT="One-Page Revision">
        <node TEXT="One database is not enough for Amazon-scale design"/>
      </node>
    </node>
    <node TEXT="Page 6 - WhatsApp-Style Chat System Design">
      <node TEXT="What You'll Learn">
        <node TEXT="Design real-time messaging, offline replay, group fan-out, and media flow"/>
      </node>
      <node TEXT="Core Idea">
        <node TEXT="Real-time delivery needs WebSocket routing plus persistent message storage"/>
      </node>
      <node TEXT="Visual Summary">
        <node TEXT="WebSocket handlers keep live connections"/>
        <node TEXT="Redis maps users to handlers"/>
        <node TEXT="Cassandra stores messages"/>
        <node TEXT="Kafka fans out group messages"/>
      </node>
      <node TEXT="Real-World Use">
        <node TEXT="Messages must still arrive when users reconnect later"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="Offline replay"/>
        <node TEXT="Read receipts"/>
        <node TEXT="Asset service for media"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Group fan-out should not overload the live socket handler"/>
      </node>
      <node TEXT="Spaced Repetition">
        <node TEXT="Rebuild one-to-one and group message paths"/>
      </node>
      <node TEXT="One-Page Revision">
        <node TEXT="Chat design mixes low latency with offline resilience"/>
      </node>
    </node>
  </node>
</map>