/*
 * Copyright (c) 2021-2024 MAGMA pipeline authors, see https://doi.org/10.1371/journal.pcbi.1011648
 *
 * This file is part of MAGMA pipeline, see https://github.com/TORCH-Consortium/MAGMA
 *
 * For quick overview of GPL-3 license, please refer
 * https://www.tldrlegal.com/license/gnu-general-public-license-v3-gpl-3
 *
 * - You MUST keep this license with original authors in your copy
 * - You MUST acknowledge the original source of this software
 * - You MUST state significant changes made to the original software
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program . If not, see <http://www.gnu.org/licenses/>.
 */
process GATK_SELECT_VARIANTS__EXCLUSION {
    tag "${joint_name}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
        val(analysisMode)
        tuple val(joint_name), path(filteredVcfIndex), path(filteredVcf)
        path(intervalFile)
        path(reference)
        path("*")


    output:
        tuple val(joint_name), path("*.filtered_${analysisMode}_exc-rRNA.vcf.gz.tbi"), path("*.filtered_${analysisMode}_exc-rRNA.vcf.gz")

    script:

        """
        ${params.gatk_path} SelectVariants --java-options "-Xmx${task.memory.giga}G" \\
            -V ${filteredVcf} \\
            --exclude-intervals ${intervalFile} \\
            ${params.arguments} \\
            -O ${joint_name}.filtered_${analysisMode}_exc-rRNA.vcf.gz

        """

    stub:

        """
        touch ${joint_name}.filtered_SNP_exc-rRNA.vcf.gz
        touch ${joint_name}.filtered_SNP_exc-rRNA.vcf.gz.tbi
        """
}
