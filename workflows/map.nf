nextflow.enable.dsl = 2

workflow MAP_WF {

    FASTQC()

    // - The RG is derived from CSV fields
    // - Accomodates both single/paired ends
    BWA_MEM
}
