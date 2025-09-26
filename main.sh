#!/usr/bin/env bash

vcf_original="/home/fernando/lgcm/projects/rare_variants/association-analysis-for-rare-variants-2025/data/input/original/REHOT_UFRJ_ELSA_original.vcf.gz"
vcf_processed="/home/fernando/lgcm/projects/rare_variants/association-analysis-for-rare-variants-2025/data/intermediate/03.vars_filtered_kinshipped/REHOT_UFRJ_ELSA_filtered.vcf.gz"

echo -e "VCF ORIGINAL:\t$(basename $vcf_original)"
echo -e "VCF PROCESSED:\t$(basename $vcf_processed)"

# original=($(bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' $vcf_original | sed 's/^chr//g'| sed 's/\t/_/g' | sort))
# processed=($(bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' $vcf_processed | sed 's/^chr//g'| sed 's/\t/_/g' | sort))
# processed_flipped=($(bcftools query -f '%CHROM\t%POS\t%ALT\t%REF\n' $vcf_processed | sed 's/^chr//g' | sed 's/\t/_/g' | sort))

# common_not_flipped=($(echo "${original[@]}" "${processed[@]}" | tr ' ' '\n' | sort | uniq -d))
# common_flipped=($(echo "${original[@]}" "${processed_flipped[@]}" | tr ' ' '\n' | sort | uniq -d))

# echo -e "Not flipped: ${#common_not_flipped[@]}"
# echo -e "Flipped: ${#common_flipped[@]}"


bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' "$vcf_original" | sed 's/^chr//' | sort > original.txt
bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' "$vcf_processed" | sed 's/^chr//' | sort > processed.txt
bcftools query -f '%CHROM\t%POS\t%ALT\t%REF\n' "$vcf_processed" | sed 's/^chr//' | sort > flipped.txt

not_flipped=$(comm -12 original.txt processed.txt | wc -l)
flipped=$(comm -12 original.txt flipped.txt | wc -l)

echo "Not flipped: $not_flipped"
echo "Flipped: $flipped"

rm original.txt processed.txt 
