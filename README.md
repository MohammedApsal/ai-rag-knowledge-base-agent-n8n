AI RAG Knowledge Base Agent

A production-style Retrieval-Augmented Generation (RAG) knowledge base agent built with n8n, Supabase, Ollama, and Google Gemini.

The system ingests company PDF knowledge, cleans and chunks the text, generates local embeddings, stores them in a Supabase vector database, and lets users ask questions through a webhook. The AI Agent retrieves relevant knowledge before generating an answer.

🚀 Project Overview

The goal of this project is to build a company knowledge assistant that can answer questions from internal documentation while reducing hallucinations.

Example questions:

What are the company's business hours?

What services does the company provide?

What is the starting price for AI automation projects?

What is the refund policy?

What contact details are available?

The agent is also instructed to say that information could not be found when the knowledge base does not contain an answer.

🏗️ Architecture

Document Ingestion Workflow

Company PDF
    ↓
Read/Write Files from Disk
    ↓
Extract from File
    ↓
Edit Fields (clean extracted text)
    ↓
Default Data Loader
    ↓
Recursive Character Text Splitter
    ↓
Ollama Embeddings (nomic-embed-text)
    ↓
Supabase Vector Store

RAG Chat Workflow

User Question
    ↓
Webhook
    ↓
AI Agent
    ├── Google Gemini Chat Model
    └── Supabase Vector Store
            ↓
      Ollama Embeddings
            ↓
      Similarity Search
    ↓
Grounded Answer
    ↓
Respond to Webhook

🧰 Tech Stack

n8n — workflow automation and orchestration

Supabase — PostgreSQL database and vector storage

pgvector — vector similarity search in PostgreSQL

Ollama — local embedding generation

nomic-embed-text — 768-dimensional embedding model

Google Gemini — response generation

PowerShell — webhook testing

🔑 Key Features

PDF document ingestion

Text extraction and cleaning

Recursive text splitting

Local embeddings with Ollama

Supabase vector storage

Semantic similarity search

AI Agent with retrieval tool

Webhook-based API endpoint

Grounded responses using company knowledge

Anti-hallucination instructions

Unknown-information handling

🧪 Testing

The workflow was tested with both knowledge-base and out-of-scope questions.

Test 1 — Business Hours

Question:

What are ABC Technologies' business hours?

Result: Correct business hours were returned from the company knowledge base.

Test 2 — Services

Question:

What services does ABC Technologies provide?

Result: The agent returned the services listed in the knowledge base.

Test 3 — Pricing

Question:

How much do ABC Technologies' AI automation projects start from?

Result: The agent returned the pricing information stored in the knowledge base.

Test 4 — Out-of-Scope Question

Question:

Who is the CEO of ABC Technologies?

Result: The agent correctly stated that the information was not available in the company knowledge base instead of inventing an answer.

⚙️ Supabase Setup

The vector table uses a 768-dimensional embedding column to match nomic-embed-text.

Example schema:

create extension if not exists vector;

create table documents (
  id bigserial primary key,
  content text,
  metadata jsonb,
  embedding vector(768)
);

The project also uses a match_documents PostgreSQL function for similarity retrieval.

🔌 Webhook API

Endpoint

POST /webhook-test/rag-chat

Request

{
  "question": "What are ABC Technologies' business hours?"
}

Response

The endpoint returns the AI Agent's grounded response as text.

🛡️ Hallucination Control

The AI Agent is instructed to:

Search the company knowledge base before answering company-related questions.

Use retrieved information rather than general knowledge.

Avoid guessing or fabricating company details.

Explicitly state when required information is not found.

📁 Suggested Repository Structure

ai-rag-knowledge-base-agent/
├── README.md
├── workflows/
│   ├── ai-rag-knowledge-base-ingestion.json
│   └── ai-rag-knowledge-base-chat.json
├── sql/
│   └── match_documents.sql
├── sample-data/
│   └── company-knowledge-base.pdf
└── screenshots/

Remove credentials, API keys, personal data, and private company documents before publishing workflow exports or sample files.

💡 What I Learned

Designing a complete RAG ingestion and retrieval pipeline

Working with vector databases and pgvector

Using local embeddings to reduce API dependency and cost

Connecting Supabase retrieval to an n8n AI Agent

Debugging embedding dimension mismatches and PostgreSQL function signatures

Testing retrieval quality and hallucination behavior

🔮 Future Improvements

Add a web-based chat interface

Add authentication and user-specific knowledge bases

Support multiple PDF/documents and automatic re-indexing

Add source citations to answers

Add conversation memory

Add evaluation metrics for retrieval quality

Deploy the workflow with production webhooks

👨‍💻 Author

MOHAMMED APSAL M

AI / GenAI • n8n Automation • RAG • AI Agents
