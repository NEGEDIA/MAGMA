include { TBPROFILER_LOAD_LIBRARY } from "../../modules/tbprofiler/load_library.nf"
include { TBPROFILER_VCF_PROFILE__COHORT } from "../../modules/tbprofiler/vcf_profile__cohort.nf" addParams (params.TBPROFILER_VCF_PROFILE__COHORT)
include { TBPROFILER_COLLATE as TBPROFILER_COLLATE__COHORT } from "../../modules/tbprofiler/collate.nf" addParams (params.TBPROFILER_COLLATE__COHORT)
include { TBPROFILER_COLLATE as TBPROFILER_COLLATE__LOFREQ } from "../../modules/tbprofiler/collate.nf" addParams (params.TBPROFILER_COLLATE__LOFREQ)
include { BGZIP } from "../../modules/bgzip/bgzip.nf" addParams (params.BGZIP)
include { TBPROFILER_VCF_PROFILE__LOFREQ } from "../../modules/tbprofiler/vcf_profile__lofreq.nf" addParams (params.TBPROFILER_VCF_PROFILE__LOFREQ)


workflow RESISTANCE_ANALYSIS {
    take:
        merged_vcf_ch
        lofreq_vcf_ch

    main:

        def database = params.resistance_db ? params.resistance_db : []

        if (!workflow.container) {
            TBPROFILER_LOAD_LIBRARY(database)
        }

        // merge_call_resistance
        TBPROFILER_VCF_PROFILE__COHORT(merged_vcf_ch, database)
        TBPROFILER_COLLATE__COHORT(params.vcf_name, TBPROFILER_VCF_PROFILE__COHORT.out, database)

        // merge_call_resistance_lofreq
        BGZIP(lofreq_vcf_ch)
        TBPROFILER_VCF_PROFILE__LOFREQ(BGZIP.out, database)
        TBPROFILER_COLLATE__LOFREQ(params.vcf_name,
                                   TBPROFILER_VCF_PROFILE__LOFREQ.out.resistance_json.collect(),
                                   database)
}
