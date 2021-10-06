
 $SNP_DISTS $OUT_DIR/fasta/$JOINT_NAME/$JOINT_NAME.95X.variable.IncComplex.fa -b > $OUT_DIR/phylogeny/$JOINT_NAME/$JOINT_NAME.IncComplex.snp_dists.tsv

nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/snpdists"
params.save_mode = 'copy'
params.should_publish = true



process process_name {
    tag "something"
    publishdir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    path(somefile)

    output:
    path("pattern"),  emit: "ch_output"

    script:

    """
    echo "nothing"
    """

    stub:

    """
    echo "nothing on stub"
    """

}
