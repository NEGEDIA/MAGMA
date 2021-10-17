nextflow.enable.dsl = 2


params.results_dir = "${params.outdir}/gatk4/merge_vcfs"
params.save_mode = 'copy'
params.should_publish = true

process GATK_MERGE_VCFS {
    tag "${joint_name}"

    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    path(filteredSnpVcf)
    path(filteredIndelVcf)

    output:
    path("*.filtered_SNP.RawIndels.vcf.gz")

    script:

    """
    gatk MergeVcfs -Xmx${task.memory.giga}G \\
        -I ${filteredSnpVcf} \\
        -I ${fileteredIndelVcf} \\
        -O ${joint_name}.filtered_SNP.RawIndels.vcf.gz
    """

    stub:

    """

    """
}

