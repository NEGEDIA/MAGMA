include { GATK_VARIANT_RECALIBRATOR as  GATK_VARIANT_RECALIBRATOR__ANN7 } from "../../modules/gatk/variant_recalibrator.nf" addParams (params.GATK_VARIANT_RECALIBRATOR__ANN7)
include { GATK_VARIANT_RECALIBRATOR as  GATK_VARIANT_RECALIBRATOR__ANN6 } from "../../modules/gatk/variant_recalibrator.nf" addParams (params.GATK_VARIANT_RECALIBRATOR__ANN6)
include { GATK_VARIANT_RECALIBRATOR as  GATK_VARIANT_RECALIBRATOR__ANN5 } from "../../modules/gatk/variant_recalibrator.nf" addParams (params.GATK_VARIANT_RECALIBRATOR__ANN5)
include { GATK_VARIANT_RECALIBRATOR as  GATK_VARIANT_RECALIBRATOR__ANN4 } from "../../modules/gatk/variant_recalibrator.nf" addParams (params.GATK_VARIANT_RECALIBRATOR__ANN4)
include { GATK_VARIANT_RECALIBRATOR as  GATK_VARIANT_RECALIBRATOR__ANN3 } from "../../modules/gatk/variant_recalibrator.nf" addParams (params.GATK_VARIANT_RECALIBRATOR__ANN3)
include { GATK_VARIANT_RECALIBRATOR as  GATK_VARIANT_RECALIBRATOR__ANN2 } from "../../modules/gatk/variant_recalibrator.nf" addParams (params.GATK_VARIANT_RECALIBRATOR__ANN2)

include { UTILS_ELIMINATE_ANNOTATION as  UTILS_ELIMINATE_ANNOTATION__ANN7;
          UTILS_ELIMINATE_ANNOTATION as  UTILS_ELIMINATE_ANNOTATION__ANN6;
          UTILS_ELIMINATE_ANNOTATION as  UTILS_ELIMINATE_ANNOTATION__ANN5;
          UTILS_ELIMINATE_ANNOTATION as  UTILS_ELIMINATE_ANNOTATION__ANN4;
          UTILS_ELIMINATE_ANNOTATION as  UTILS_ELIMINATE_ANNOTATION__ANN3
} from "../../modules/utils/eliminate_annotation.nf" addParams ( params.UTILS_ELIMINATE_ANNOTATION )



workflow OPTIMIZE_VARIANT_RECALIBRATION {
    take:
        analysisType
        select_variants_vcftuple_ch
        args_ch
        resources_files_ch
        resources_file_indexes_ch


    main:

        GATK_VARIANT_RECALIBRATOR__ANN7(analysisType,
                                    " -an DP -an AS_QD -an AS_MQ -an AS_FS -an AS_SOR -an AS_MQRankSum -an AS_ReadPosRankSum ",
                                    select_variants_vcftuple_ch,
                                    args_ch,
                                    resources_files_ch,
                                    resources_file_indexes_ch,
                                    params.ref_fasta,
                                    [params.ref_fasta_fai, params.ref_fasta_dict] )


//------------------------

        UTILS_ELIMINATE_ANNOTATION__ANN7(analysisType,
                                        GATK_VARIANT_RECALIBRATOR__ANN7.out.annotationsLog)


        ann6_ch = UTILS_ELIMINATE_ANNOTATION__ANN7.out
                    .map { it.text }


        GATK_VARIANT_RECALIBRATOR__ANN6(analysisType,
                                    ann6_ch,
                                    select_variants_vcftuple_ch,
                                    args_ch,
                                    resources_files_ch,
                                    resources_file_indexes_ch,
                                    params.ref_fasta,
                                    [params.ref_fasta_fai, params.ref_fasta_dict] )

//------------------------

        UTILS_ELIMINATE_ANNOTATION__ANN6(analysisType,
                                        GATK_VARIANT_RECALIBRATOR__ANN6.out.annotationsLog)


        ann5_ch = UTILS_ELIMINATE_ANNOTATION__ANN6.out
                    .map { it.text }


        GATK_VARIANT_RECALIBRATOR__ANN5(analysisType,
                                    ann5_ch,
                                    select_variants_vcftuple_ch,
                                    args_ch,
                                    resources_files_ch,
                                    resources_file_indexes_ch,
                                    params.ref_fasta,
                                    [params.ref_fasta_fai, params.ref_fasta_dict] )



//------------------------

        UTILS_ELIMINATE_ANNOTATION__ANN5(analysisType,
                                        GATK_VARIANT_RECALIBRATOR__ANN5.out.annotationsLog)


        ann4_ch = UTILS_ELIMINATE_ANNOTATION__ANN5.out
                    .map { it.text }


        GATK_VARIANT_RECALIBRATOR__ANN4(analysisType,
                                    ann4_ch,
                                    select_variants_vcftuple_ch,
                                    args_ch,
                                    resources_files_ch,
                                    resources_file_indexes_ch,
                                    params.ref_fasta,
                                    [params.ref_fasta_fai, params.ref_fasta_dict] )

//------------------------

        UTILS_ELIMINATE_ANNOTATION__ANN4(analysisType,
                                        GATK_VARIANT_RECALIBRATOR__ANN4.out.annotationsLog)

        ann3_ch = UTILS_ELIMINATE_ANNOTATION__ANN4.out
                    .map { it.text }


        GATK_VARIANT_RECALIBRATOR__ANN3(analysisType,
                                    ann3_ch,
                                    select_variants_vcftuple_ch,
                                    args_ch,
                                    resources_files_ch,
                                    resources_file_indexes_ch,
                                    params.ref_fasta,
                                    [params.ref_fasta_fai, params.ref_fasta_dict] )

//------------------------


        UTILS_ELIMINATE_ANNOTATION__ANN3(analysisType,
                                        GATK_VARIANT_RECALIBRATOR__ANN3.out.annotationsLog)

        ann2_ch = UTILS_ELIMINATE_ANNOTATION__ANN3.out
                    .map { it.text }

        GATK_VARIANT_RECALIBRATOR__ANN2(analysisType,
                                    ann2_ch,
                                    select_variants_vcftuple_ch,
                                    args_ch,
                                    resources_files_ch,
                                    resources_file_indexes_ch,
                                    params.ref_fasta,
                                    [params.ref_fasta_fai, params.ref_fasta_dict] )


    emit:

        optimized_vqsr_ch = select_variants_vcftuple_ch
                            .join(GATK_VARIANT_RECALIBRATOR__ANN2.out.recalVcfTuple)
                            .join(GATK_VARIANT_RECALIBRATOR__ANN2.out.tranchesFile)


}
