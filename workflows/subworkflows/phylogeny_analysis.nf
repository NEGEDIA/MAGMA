include { GATK_SELECT_VARIANTS } from "../../modules/gatk/select_variants.nf" addParams ( params.GATK_SELECT_VARIANTS__PHYLOGENY__SNP )

workflow PHYLOGENY_ANALYSIS {

    take:
    val(prefix)
    tuple val(joint_name), path(vcfIndex), path(vcf)
    path(rrna)


    //----------
    // Including complex regions
    //----------


    arg_files_ch = Channel.of([file(params.coll2018_vcf), file(params.coll2018_vcf_tbi)])
        .ifEmpty([])
        .map { it -> it != [] ? [ "${it[0]} ${it[1].getName()}", it[1] ] : [] }
        .flatten()


    args_ch = arg_files_ch
        .filter { it.class == org.codehaus.groovy.runtime.GStringImpl }
        .reduce { a, b -> "$a -XL:$b " }
        .ifEmpty("")
        .view()


    files_ch = arg_files_ch
        .filter { it.class != org.codehaus.groovy.runtime.GStringImpl }
        .collect()
        .ifEmpty([])
        .view()

    // $GATK SelectVariants \\
    // -V $OUT_DIR/vcf/$JOINT_NAME/$JOINT_NAME.filtered_SNP_exc-rRNA.vcf.gz \\
    // -XL $RESOURCE_PATH/Coll2018.vcf.gz

    // merge_phylogeny_prep_inccomplex
    // GATK_SELECT_VARIANTS('SNP',
    //                      'ExDR.IncComplex',
    //                      annotatedSnp,
    //                      args_ch,
    //                      resources_files_ch,
    //                      resources_file_indexes_ch,
    //                      reference
    //                      [params.ref_fasta_fai, params.ref_fasta_dict])

    /*
    GATK_VARIANTS_TO_TABLE
    SNP_SITES
    SNP_DISTS

    // merge_iqtree_inccomplex
    IQTREE


    //----------
    // Excluding complex regions
    //----------

    arg_files_ch = Channel.of([file("UVP_List_of_Excluded_loci.list")
                               file("Coll2018.vcf.gz")])
        .ifEmpty([])
        .map { it -> it != [] ? [ "${it[0]} ${it[1].getName()}", it[1] ] : [] }
        .flatten()


    args_ch = arg_files_ch
        .filter { it.class == org.codehaus.groovy.runtime.GStringImpl }
        .reduce { a, b -> "$a -XL:$b " }
        .ifEmpty("")
        .view()


    files_ch = arg_files_ch
        .filter { it.class != org.codehaus.groovy.runtime.GStringImpl }
        .collect()
        .ifEmpty([])
        .view()



    // merge_phylogeny_prep_excomplex
    GATK_SELECT_VARIANTS__INDEL('INDEL')
    GATK_VARIANTS_TO_TABLE
    SNP_SITES
    SNP_DISTS

    // merge_iqtree_excomplex
    IQTREE

*/

}
