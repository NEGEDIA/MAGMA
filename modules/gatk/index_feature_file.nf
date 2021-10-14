/*
FIXME: Documentation comments

*/


process GATK_INDEX_FEATURE_FILE {
    tag "${sampleName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish


    input:
    tuple val(sampleName), path(annotatedVcf)


    output:
    //FIXME
    val(sampleName)


    script:

    """
    gatk IndexFeatureFile -Xmx${task.memory.giga}G \\
        -I ${annotatedVcf}
    """

    stub:

    """

    """
}
