nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/quanttb"
params.save_mode = 'copy'
params.should_publish = true



process QUANTTB_QUANT {
    tag "${sampleName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(sampleName), path(sampleReads)

    output:
    tuple val(sampleName), path("*.quant.txt")

    script:

    """
    quanttb quant ${sampleReads} -o ${sampleName}.quant.txt -k
    """

    stub:

    """

    echo "quanttb quant ${sampleReads} -o ${sampleName}.quant.txt -k"

    touch ${sampleName}.quant.txt
    """

}
