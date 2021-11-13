include { GATK_SELECT_VARIANTS as GATK_SELECT_VARIANTS__PHYLOGENY } from "../../modules/gatk/select_variants.nf" addParams( params.GATK_SELECT_VARIANTS__PHYLOGENY )
include { GATK_VARIANTS_TO_TABLE } from "../../modules/gatk/variants_to_table.nf" addParams( params.GATK_VARIANTS_TO_TABLE )
include { SNPSITES } from "../../modules/snpsites/snpsites.nf" addParams( params.SNPSITES )
include { SNPDISTS } from "../../modules/snpdists/snpdists.nf" addParams( params.SNPDISTS )
include { IQTREE } from "../../modules/iqtree/iqtree.nf" addParams( params.IQTREE )

workflow PHYLOGENY_ANALYSIS {

    take:
        prefix_ch
        arg_files_ch
        vcf_ch

    main:

        //----------
        // Including complex regions
        //----------


        resources_files_ch = arg_files_ch
            .filter {  it.getExtension()  == "gz" }
            .ifEmpty([])
            // .view()


        args_ch = resources_files_ch
        .reduce (" ") { a, b -> {
                if (b.class == sun.nio.fs.UnixPath) {
                    return "$a -XL ${b.getName()} "

                } else {
                    return ""
                }
            }
        }
            // .view()


        resources_file_indexes_ch = arg_files_ch
            .filter {  it.getExtension()  == "tbi" }
            .collect()
            .ifEmpty([])
            // .view()



        // merge_phylogeny_prep_inccomplex
        GATK_SELECT_VARIANTS__PHYLOGENY('SNP',
                            prefix_ch,
                            vcf_ch,
                            args_ch,
                            resources_files_ch,
                            resources_file_indexes_ch,
                            params.ref_fasta,
                            [params.ref_fasta_fai, params.ref_fasta_dict])

        GATK_VARIANTS_TO_TABLE(prefix_ch, GATK_SELECT_VARIANTS__PHYLOGENY.out)

        SNPSITES(prefix_ch, GATK_VARIANTS_TO_TABLE.out)

        SNPDISTS(prefix_ch, SNPSITES.out)

        // merge_iqtree_inccomplex
        IQTREE(prefix_ch, SNPSITES.out)


        /*
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
            .reduce (" ") { a, b -> "$a -XL:$b " }
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
