-- RAG Knowledge Base: Supabase vector search function
-- Embedding model: Ollama nomic-embed-text (768 dimensions)

DROP FUNCTION IF EXISTS public.match_documents(vector, integer);
DROP FUNCTION IF EXISTS public.match_documents(jsonb, integer, vector);

CREATE OR REPLACE FUNCTION public.match_documents (
  filter jsonb,
  match_count integer,
  query_embedding vector(768)
)
RETURNS TABLE (
  id bigint,
  content text,
  metadata jsonb,
  similarity float
)
LANGUAGE sql
AS $$
  SELECT
    documents.id,
    documents.content,
    documents.metadata,
    1 - (documents.embedding <=> query_embedding) AS similarity
  FROM public.documents
  WHERE documents.metadata @> filter
  ORDER BY documents.embedding <=> query_embedding
  LIMIT match_count;
$$;
