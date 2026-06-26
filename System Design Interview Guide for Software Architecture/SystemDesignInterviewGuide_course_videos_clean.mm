<?xml version="1.0" encoding="UTF-8"?>
<map version="1.0.1">
  <node TEXT="System Design Interview Guide">
    <node TEXT="Page 1 — Introduction to the Interview Series" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="structured interview decomposition"/>
        <node TEXT="Prompt -&gt; Requirements -&gt; Scale -&gt; Components -&gt; Trade-offs"/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Functional requirements governs a critical subsystem boundary."/>
        <node TEXT="Non-functional requirements changes operational ownership or data authority."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Clarify the product and user flows."/>
        <node TEXT="Estimate scale and hotspots."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Good interview performance comes from showing decision logic, not from memorizing one architecture diagram per company."/>
        <node TEXT="Pick one app you use every day."/>
      </node>
    </node>
    <node TEXT="Page 2 — Choosing the Right Database" ARCHETYPE="type_c" SCALE="macro">
      <node TEXT="Functional Mechanics">
        <node TEXT="Database choice mostly changes non-functional behavior: consistency guarantees, latency, throughput, and operational scaling."/>
        <node TEXT="Structured transactional data fits relational systems; flexible documents fit document stores; text search belongs in Lucene-based engines; append-only metrics favor time-series or wide-column systems."/>
      </node>
      <node TEXT="Concrete Configuration &amp; Code Snippets">
        <node TEXT="Data shape matters"/>
        <node TEXT="Classify the data shape."/>
      </node>
      <node TEXT="Edge Cases &amp; System Constraints">
        <node TEXT="Real products often combine multiple databases so each subsystem gets the right optimization instead of one compromised global choice."/>
        <node TEXT="Explain why each store owns that workload."/>
      </node>
    </node>
    <node TEXT="Page 3 — URL Shortener System Design" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Estimate keyspace and lifetime volume."/>
        <node TEXT="Generate collision-resistant short codes."/>
        <node TEXT="Persist short-to-long mapping."/>
        <node TEXT="Resolve redirects with one fast lookup."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="A social product needs billions of short links that must redirect fast even during traffic spikes."/>
        <node TEXT="Long URL -&gt; Shortener -&gt; Token range -&gt; Mapping store"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="The redirect path should do the minimum work possible: resolve the short code, fetch the long URL, and return a redirect quickly."/>
        <node TEXT="Estimate whether 7 characters of base62 are enough."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Click analytics belong off the hot path through buffering or streaming so measurement never slows user redirection."/>
        <node TEXT="Clicks -&gt; Stream -&gt; Analytics"/>
      </node>
    </node>
    <node TEXT="Page 4 — Airbnb / Booking.com System Design" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Search hotels and availability."/>
        <node TEXT="Lock or hold the selected room."/>
        <node TEXT="Process payment inside a timeout."/>
        <node TEXT="Commit booking transaction."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="Two travelers try to book the last room at the same time, so inventory correctness matters more than a pretty UI."/>
        <node TEXT="Search index for discovery"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Redis-style TTL storage is useful for expiring abandoned holds, while durable relational storage remains the source of truth for final booking state."/>
        <node TEXT="List which store owns search and which store owns booking correctness."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Historical and analytical data can move to cheaper, scalable stores because the correctness-critical path is the inventory mutation itself."/>
        <node TEXT="Archive store for long history"/>
      </node>
    </node>
    <node TEXT="Page 5 — Amazon-Style Commerce System" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="service decomposition across catalog, search, inventory, cart, orders, payments, and media delivery"/>
        <node TEXT="Catalog -&gt; Search -&gt; Product detail -&gt; Cart -&gt; Order -&gt; Payment"/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Catalog service governs a critical subsystem boundary."/>
        <node TEXT="Search index changes operational ownership or data authority."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Define buyer, seller, and admin flows."/>
        <node TEXT="Keep inventory and orders transactionally safe."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="The interview win is to show why boundaries exist: they isolate scaling hotspots, preserve transactional correctness where needed, and reduce blast radius."/>
        <node TEXT="Name three subsystems that should not share the same database design."/>
      </node>
    </node>
    <node TEXT="Page 6 — WhatsApp-Style Chat System" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Accept message on persistent connection."/>
        <node TEXT="Persist and enqueue the message."/>
        <node TEXT="Fan out to recipient sessions or offline inbox."/>
        <node TEXT="Update delivery/read status."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="A messenger app must deliver billions of messages quickly while tolerating offline users and mobile reconnections."/>
        <node TEXT="Sender socket -&gt; Chat service -&gt; Queue/store -&gt; Recipient socket"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Read receipts and presence signals are lightweight state updates that should not block the core message path."/>
        <node TEXT="Name one component that should stay out of the hot message path."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Media attachments, profile data, and analytics each scale differently from raw message transport and should be decomposed accordingly."/>
        <node TEXT="Media and profile flows are side services"/>
      </node>
    </node>
    <node TEXT="Page 7 — Notification System at Scale" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Publish a notification intent."/>
        <node TEXT="Apply template and preference rules."/>
        <node TEXT="Route by channel."/>
        <node TEXT="Deliver through provider-specific worker."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="A product sends order updates, promotions, and alerts across multiple channels without coupling every producer to every delivery provider."/>
        <node TEXT="Producer event -&gt; Notification bus -&gt; Channel handler -&gt; Provider -&gt; Status"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Retries, backoff, and dead-lettering matter because third-party delivery APIs fail in partial, time-based ways."/>
        <node TEXT="Explain why producers should not call providers directly."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Templates, user preferences, and channel policies should be applied before final provider submission so behavior stays consistent."/>
        <node TEXT="Retries and DLQ handle transient failures"/>
      </node>
    </node>
    <node TEXT="Page 8 — Uber-Style Ride Hailing" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Ingest driver pings."/>
        <node TEXT="Index drivers by geo region."/>
        <node TEXT="Match rider request to candidate drivers."/>
        <node TEXT="Commit trip state transitions."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="A rider opens the app, sees nearby drivers, requests a trip, and expects matching in seconds while vehicles keep moving."/>
        <node TEXT="Location ingest -&gt; Geo index -&gt; Match engine -&gt; Trip state -&gt; Payment"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Matching logic often combines proximity, surge, vehicle type, and driver availability rather than simple nearest-distance alone."/>
        <node TEXT="Describe one reason the nearest driver may not be selected."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Payments and receipts belong after trip completion and should not slow the live matching loop."/>
        <node TEXT="Live map updates are hotter than billing writes"/>
      </node>
    </node>
    <node TEXT="Page 9 — Twitter-Style Feed System" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Persist tweet and metadata."/>
        <node TEXT="Resolve follower graph impact."/>
        <node TEXT="Choose fan-out policy."/>
        <node TEXT="Store or cache feed entries."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="One celebrity posts once and millions of followers expect to see the tweet immediately, creating extreme asymmetric load."/>
        <node TEXT="Tweet -&gt; Graph -&gt; Fan-out strategy -&gt; Feed store/cache -&gt; Timeline read"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Fan-out on read reduces write amplification but pushes more computation into the read path and caching layer."/>
        <node TEXT="Name one cache that helps the read path."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="A hybrid strategy is common: precompute many feeds while treating celebrity content with special handling."/>
        <node TEXT="Hybrid approach handles celebrity skew"/>
      </node>
    </node>
    <node TEXT="Page 10 — Facebook / Instagram Feed &amp; Social Graph" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="social graph, media distribution, ranking, and notification coordination for a consumer network"/>
        <node TEXT="Identity + graph are the core model"/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Social graph governs a critical subsystem boundary."/>
        <node TEXT="Feed ranking changes operational ownership or data authority."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Store user and graph relationships."/>
        <node TEXT="Generate or rank feed candidates."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="The architecture should highlight which parts need consistency and which parts tolerate eventual propagation."/>
        <node TEXT="Separate one consistency-critical component from one eventually consistent component."/>
      </node>
    </node>
    <node TEXT="Page 11 — YouTube / Netflix Video Platform" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Receive upload and store original."/>
        <node TEXT="Fan out transcoding jobs."/>
        <node TEXT="Publish manifests and metadata."/>
        <node TEXT="Distribute renditions to CDN."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="A user uploads a huge video file once, but millions of viewers consume many bitrate versions across the globe."/>
        <node TEXT="Upload -&gt; Original store -&gt; Transcode farm -&gt; Manifest -&gt; CDN -&gt; Player"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Recommendation, search, and watch-history analytics are adjacent systems that influence discovery but should not block stream start."/>
        <node TEXT="Name two outputs produced from one upload."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="The architecture must explain why object storage, transcoding workers, manifests, and edge caches are separate stages."/>
        <node TEXT="Analytics and recommendations stay adjacent, not inline"/>
      </node>
    </node>
    <node TEXT="Page 12 — Zoom / Video Calling System" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Create or join room through signaling."/>
        <node TEXT="Negotiate connection details."/>
        <node TEXT="Route media through relay/forwarding layer."/>
        <node TEXT="Manage participant events and device changes."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="A meeting starts instantly, participants join from unstable networks, and audio/video must stay smooth enough for conversation."/>
        <node TEXT="Signal room -&gt; Negotiate media -&gt; Relay video/audio -&gt; Side-record if needed"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Recording and analytics are side flows that should observe media or metadata without destabilizing live conversation."/>
        <node TEXT="Name one reason recording should be a side branch."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="The interview emphasis is on latency budgets, participant fan-out, NAT traversal, and graceful degradation under poor network conditions."/>
        <node TEXT="Live latency beats heavy server-side processing"/>
      </node>
    </node>
    <node TEXT="Page 13 — Google Maps / Location Platform" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="map tile serving, geospatial indexing, routing computation, live traffic updates, and search integration"/>
        <node TEXT="Tiles for base map"/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Map tile cache governs a critical subsystem boundary."/>
        <node TEXT="Road graph changes operational ownership or data authority."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Serve map tiles and place data."/>
        <node TEXT="Run route search on road graph."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="A strong answer shows how cached geography and live telemetry cooperate without forcing every request to recompute the entire world state."/>
        <node TEXT="Explain why map tiles and routing should scale differently."/>
      </node>
    </node>
    <node TEXT="Page 14 — Biggest Mistakes to Avoid" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Clarify before drawing."/>
        <node TEXT="Estimate before sizing."/>
        <node TEXT="Justify every major component."/>
        <node TEXT="Name bottlenecks and mitigations."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="Candidates know system components but still fail because they skip scope clarification, ignore scale, or jump straight to technology names."/>
        <node TEXT="Bad path: assume -&gt; jump to tools -&gt; ignore scale"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Ignoring bottlenecks, edge cases, or failure handling suggests the architecture is superficial even when the main boxes look correct."/>
        <node TEXT="Replace one tool-name statement with a constraint-based reason."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Strong closings summarize trade-offs, note follow-up improvements, and show awareness of what was intentionally simplified."/>
        <node TEXT="Good path: clarify -&gt; estimate -&gt; design -&gt; justify"/>
      </node>
    </node>
  </node>
</map>