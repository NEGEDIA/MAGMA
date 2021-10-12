/*
FIXME: Documentation comments

*/


process LOFREQ_CALL_NTM {
    tag "${sampleName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(sampleName), path(recalibratedBam)
    path(ref_fasta)

    output:
    tuple val(sampleName), path("*.potential_NTM_fraction.txt")

    shell:

    '''
	lofreq call \\
	    -f !{ref_fasta} \\
	    -r !{ref_fasta.getName()}:!{params.region} \\
        !{arguments} \\
	    !{recalibratedBam} \\
	| grep -v "#" \\
	| cut -f 2 -d ";" \\
	| tr -d 'AF=' \\
	| awk '{Total=Total+$1} END{print Total}' \\
	> !{sampleName}.potential_NTM_fraction.txt
    '''

    stub:

    """
	echo "${ref_fasta} -- ${ref_fasta.getName()} -- ${params.region} -- ${sampleName} -- ${recalibratedBam}"


    touch ${sampleName}.potential_NTM_fraction.txt
    """

}
