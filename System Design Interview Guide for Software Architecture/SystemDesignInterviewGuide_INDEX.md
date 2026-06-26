# SystemDesignInterviewGuide — Topic Index

> Quick-navigation index for all pages, concepts, and review items.

## Table of Contents
| # | Page Title | Difficulty | Topics Covered |
|---|---|---|---|
| 2 | Introduction | Easy | Functional requirements, Non-functional requirements, Trade-off framing |
| 3 | Choosing the Right DB | Medium | RDBMS, Document DB, Search engine |
| 4 | URL Shortner System Design | Medium | Base62 keyspace, Collision avoidance, Asynchronous analytics |
| 5 | Airbnb / Booking.com System Design | Hard | Reservation hold, Inventory source of truth, TTL expiry |
| 6 | Amazon System Design | Hard | Catalog service, Search index, Order state machine |
| 7 | Whatsapp System Design | Hard | Persistent connection, Offline inbox, Delivery receipt |
| 8 | Notification System at scale | Medium | Channel handler, Dead-letter queue, Preference engine |
| 9 | Uber System Design | Hard | Geo index, Trip state machine, Surge-aware matching |
| 10 | Twitter System Design | Hard | Follower graph, Fan-out on write, Hybrid timeline strategy |
| 11 | Facebook / Instagram System Design | Hard | Social graph, Feed ranking, Media CDN |
| 12 | YouTube / Netflix System Design | Hard | Transcoding, Manifest, CDN edge cache |
| 13 | Zoom System Design | Hard | Signaling plane, Media relay/SFU, Graceful degradation |
| 14 | Google Maps System Design | Hard | Map tile cache, Road graph, Traffic weighting |
| 15 | Biggest mistakes to avoid in the interview | Easy | Scope control, Reasoned choice, Failure narration |

## All Key Concepts (A–Z)
- **Asynchronous analytics** — Buffered click processing outside the redirect hot path. *(Page 3)*
- **Base62 keyspace** — Compact alphabet that packs many unique tokens into short strings. *(Page 3)*
- **Blob storage + CDN** — Pattern for images and videos where distribution beats querying. *(Page 2)*
- **CDN edge cache** — Regional copy layer that cuts buffering and origin load. *(Page 11)*
- **Catalog service** — Owns product descriptions and seller-managed attributes. *(Page 5)*
- **Channel handler** — Worker specialized for one transport such as email, SMS, push, or chat. *(Page 7)*
- **Collision avoidance** — Technique that guarantees two long URLs do not receive the same token. *(Page 3)*
- **Dead-letter queue** — Holding area for messages that fail repeated delivery attempts. *(Page 7)*
- **Delivery receipt** — State marker that tracks sent, delivered, and read progression. *(Page 6)*
- **Document DB** — Flexible schema store for attribute-heavy entities. *(Page 2)*
- **Failure narration** — Calling out what breaks and how you would mitigate it. *(Page 14)*
- **Fan-out on write** — Push model that updates recipient feeds during tweet creation. *(Page 9)*
- **Feed ranking** — Scoring pipeline that decides which content appears first. *(Page 10)*
- **Follower graph** — Relationship map that determines who may receive a tweet in their feed. *(Page 9)*
- **Functional requirements** — User-visible capabilities the system must provide. *(Page 1)*
- **Geo index** — Spatial lookup structure for nearest-driver search. *(Page 8)*
- **Graceful degradation** — Policy for reducing quality before dropping the call entirely. *(Page 12)*
- **Hybrid timeline strategy** — Blend of precomputed feeds and on-demand composition. *(Page 9)*
- **Inventory source of truth** — Store that must remain transactionally correct for room counts. *(Page 4)*
- **Manifest** — Playback map that tells the player which chunks and renditions exist. *(Page 11)*
- **Map tile cache** — Precomputed geographic rendering slices for fast panning and zooming. *(Page 13)*
- **Media CDN** — Global edge distribution path for photos and videos. *(Page 10)*
- **Media relay/SFU** — Forwarding layer optimized for real-time participant fan-out. *(Page 12)*
- **Non-functional requirements** — Quality goals like latency, throughput, durability, and availability. *(Page 1)*
- **Offline inbox** — Durable store for recipients not currently connected. *(Page 6)*
- **Order state machine** — Durable lifecycle from created to paid to shipped to delivered. *(Page 5)*
- **Persistent connection** — Long-lived channel that reduces per-message handshake overhead. *(Page 6)*
- **Preference engine** — Rule set that decides whether and how a user should be contacted. *(Page 7)*
- **RDBMS** — Strong fit for ACID transactions and richly relational data. *(Page 2)*
- **Reasoned choice** — Technology selection tied to workload and constraints. *(Page 14)*
- **Reservation hold** — Temporary claim that prevents parallel buyers from taking the same room. *(Page 4)*
- **Road graph** — Network model of roads and intersections used by routing algorithms. *(Page 13)*
- **Scope control** — Deliberate narrowing of the question so the design matches the actual prompt. *(Page 14)*
- **Search engine** — Lucene-based index optimized for full-text and fuzzy search. *(Page 2)*
- **Search index** — Optimized read model for discovery and filtering. *(Page 5)*
- **Signaling plane** — Control path for session setup and membership events. *(Page 12)*
- **Social graph** — Relationship network that controls reach, privacy, and recommendation edges. *(Page 10)*
- **Surge-aware matching** — Policy layer that blends proximity with marketplace balancing. *(Page 8)*
- **TTL expiry** — Automatic release mechanism for stale holds. *(Page 4)*
- **Trade-off framing** — Explaining why one option wins under a given constraint set. *(Page 1)*
- **Traffic weighting** — Dynamic cost adjustment that changes the best path and ETA. *(Page 13)*
- **Transcoding** — Conversion of a master file into many playback-friendly formats and bitrates. *(Page 11)*
- **Trip state machine** — Lifecycle from requested to accepted to in-progress to completed/cancelled. *(Page 8)*

## Flashcard Export
Use `SystemDesignInterviewGuide_Flashcards.csv` as the canonical active-recall source.
- Total cards: 65
- Tag groups: density-layer:3, section:let-s-review-our-learnings, definition/purpose, density-layer:2, sequence/order, application/scenario, comparison/trade-off, section:system-design-case-studies-practical-real-world-applications

## Quick-Find by Topic
### Interview Foundations
- Page 1: Introduction to the Interview Series — Functional requirements
- Page 2: Choosing the Right Database — RDBMS
### Marketplace & Booking Systems
- Page 3: URL Shortener System Design — Base62 keyspace
- Page 4: Airbnb / Booking.com System Design — Reservation hold
- Page 5: Amazon-Style Commerce System — Catalog service
### Messaging, Notification & Mobility
- Page 6: WhatsApp-Style Chat System — Persistent connection
- Page 7: Notification System at Scale — Channel handler
- Page 8: Uber-Style Ride Hailing — Geo index
### Social, Media & Mapping
- Page 9: Twitter-Style Feed System — Follower graph
- Page 10: Facebook / Instagram Feed & Social Graph — Social graph
- Page 11: YouTube / Netflix Video Platform — Transcoding
- Page 12: Zoom / Video Calling System — Signaling plane
- Page 13: Google Maps / Location Platform — Map tile cache
### Interview Pitfalls
- Page 14: Biggest Mistakes to Avoid — Scope control
