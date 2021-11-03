
// SAMPLE    AVG_INSERT_SIZE      MAPPED_%    RAW_TOTAL_SEQS    AVERAGE_QUALITY    QUANTTB_RELATIVE_ABUNDANCE     RELATIVE_ABUNDANCE_THRESHOLD_MET    QUANTTB_DEPTH    MEAN_COVERAGE    SD_COVERAGE       NTM_FRACTION_THRESHOLD_MET       MEDIAN_COVERAGE    MAD_COVERAGE    PCT_EXC_ADAPTER    PCT_EXC_MAPQ    PCT_EXC_DUPE    PCT_EXC_UNPAIRED    PCT_EXC_BASEQ    PCT_EXC_OVERLAP    PCT_EXC_CAPPED    PCT_EXC_TOTAL    PCT_1X    PCT_5X    PCT_10X    PCT_30X    PCT_50X    PCT_100X    NTM_FRACTION
// ${i}      ${TOTAL_SEQS}      ${MAPPED_P}    ${INS_SIZE}    ${AVG_QUAL}          ${REL_ABUNDANCE}                 $(rel_abundance_threshold_met)       ${DEPTH}       ${WGS_METR}      ${NTM_FRACTION}   $(ntm_fraction_threshold_met)


process UTILS_COHORT_STATS {
    tag "joint_name: ${params.vcf_name}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    path("sample_stats/*")

    output:
    path("*.cohort_stats.tsv")

    shell:
    '''
    echo -e "SAMPLE\tAVG_INSERT_SIZE\tMAPPED_PERCENTAGE\tRAW_TOTAL_SEQS\tAVERAGE_QUALITY\tQUANTTB_RELATIVE_ABUNDANCE\tQUANTTB_DEPTH\tMEAN_COVERAGE\tSD_COVERAGE\tMEDIAN_COVERAGE\tMAD_COVERAGE\tPCT_EXC_ADAPTER\tPCT_EXC_MAPQ\tPCT_EXC_DUPE\tPCT_EXC_UNPAIRED\tPCT_EXC_BASEQ\tPCT_EXC_OVERLAP\tPCT_EXC_CAPPED\tPCT_EXC_TOTAL\tPCT_1X\tPCT_5X\tPCT_10X\tPCT_30X\tPCT_50X\tPCT_100X\tNTM_FRACTION\tNTM_FRACTION_THRESHOLD_MET\tRELATIVE_ABUNDANCE_THRESHOLD_MET\tCOVERAGE_THRESHOLD_MET\tBREADTH_OF_COVERAGE_THRESHOLD_MET\tALL_THRESHOLDS_MET" > !{params.vcf_name}.cohort_stats.tsv
    cat sample_stats/*tsv >> !{params.vcf_name}.cohort_stats.tsv
    '''
}
