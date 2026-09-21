
#!/bin/bash
# Usage: ./find_homologs.sh <query file> <subject file> <output file>

QUERY=$1
SUBJECT=$2
OUTPUT=$3

# Run tblastn (Protein query against Nucleotide subject).
# We request the standard outfmt 6 columns, plus 'qlen' (query length) at the end 
# so we can calculate the match length percentage.
tblastn -query "$QUERY" -subject "$SUBJECT" -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qlen" | \
awk -v OFS="\t" '$3 > 30 && $4 > 0.9 * $13 {NF=12; print}' > "$OUTPUT"

# Print the number of matches to stdout
wc -l < "$OUTPUT"