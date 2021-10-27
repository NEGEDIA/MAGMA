process GATK_INDEX_FEATURE_FILE {
    tag "${sampleName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish


    input:
    tuple val(sampleName), path(structuralVariantsVcf)


    output:
    tuple val(sampleName), path("*.potentialSV.idx.vcf.gz"), path(structuralVariantsVcf)


    script:

    """
    ${params.gatk_path} IndexFeatureFile --java-options "-Xmx${task.memory.giga}G" \\
        -I ${structuralVariantsVcf} \\
        -O ${sampleName}.potentialSV.idx.vcf.gz
    """

    stub:

    """
    touch ${sampleName}.potentialSV.idx.vcf.gz

    """
}
