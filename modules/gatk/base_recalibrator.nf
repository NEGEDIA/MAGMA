process GATK_BASE_RECALIBRATOR {
    tag "$sampleName"

    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(sampleName), path(dedupedBam)
    path(dbsnp)
    path(ref_fasta)

    output:
    tuple val(sampleName), path("*.recal_data.table"), path(dedupedBam)

    script:

    """
    ${params.gatk_path} BaseRecalibrator --java-options "-Xmx${task.memory.giga}G" \\
        --known-sites ${dbsnp} \\
        -R ${ref_fasta} \\
        -I ${dedupedBam} \\
        -O ${sampleName}.recal_data.table
    """

    stub:

    """
    echo "gatk BaseRecalibrator -Xmx${task.memory.giga}G \\
        --known-sites ${dbsnp} \\
        -R ${ref_fasta} \\
        -I ${dedupedBam} \\
        -O ${sampleName}.recal_data.table"

    touch ${sampleName}.recal_data.table
    """
}
