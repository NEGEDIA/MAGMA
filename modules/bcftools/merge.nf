process BCFTOOLS_MERGE {
    tag "${params.vcf_name}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
        val(vcfs_string_ch)
        path("*")

    output:
        path("*.LoFreq.vcf.gz")

    script:

        """
        bcftools merge -o ${sampleName}.LoFreq.vcf.gz ${vcfs_string_ch}
        """

    stub:

        """
        touch ${sampleName}.LoFreq.vcf.gz
        """

}
