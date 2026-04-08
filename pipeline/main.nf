#!/usr/bin/env nextflow
// hash:sha256:deee86c7d9ceee707fc9ec27987439f692b7973276b4549ab52b877686ddb096

// capsule - aind-fip-nwb-base-standalone
process capsule_aind_fip_nwb_base_standalone_2 {
	tag 'capsule-1510487'
	container "$REGISTRY_HOST/published/8ad7652f-d8cb-4104-a2fe-1c45ebf0fb2b:v7"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/fiber_raw_data'

	output:
	path 'capsule/results/*', emit: to_capsule_aind_fip_dff_3_4
	path 'capsule/results/alignment-qc', emit: to_capsule_aind_generic_quality_control_evaluation_aggregator_4_5

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8ad7652f-d8cb-4104-a2fe-1c45ebf0fb2b
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1510487.git" capsule-repo
	else
		git -c credential.helper= clone --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1510487.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-fip-qc-raw
process capsule_aind_fip_qc_raw_1 {
	tag 'capsule-8999280'
	container "$REGISTRY_HOST/published/3ae91e80-10b6-4659-814a-8afee9359a40:v9"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/fiber_raw_data'

	output:
	path 'capsule/results/*', emit: to_capsule_aind_generic_quality_control_evaluation_aggregator_4_8

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=3ae91e80-10b6-4659-814a-8afee9359a40
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v9.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8999280.git" capsule-repo
	else
		git -c credential.helper= clone --branch v9.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8999280.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-fip-dff
process capsule_aind_fip_dff_3 {
	tag 'capsule-3526719'
	container "$REGISTRY_HOST/capsule/26792844-1b2c-400d-8514-42d58028e5e5"

	cpus 2
	memory '15 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/fib\\.nwb\\.zarr") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/fiber_raw_data'
	path 'capsule/data/'

	output:
	path 'capsule/results/fib.nwb.zarr'
	path 'capsule/results/*.json', emit: to_capsule_aind_generic_quality_control_evaluation_aggregator_4_6
	path 'capsule/results/dff-qc', emit: to_capsule_aind_generic_quality_control_evaluation_aggregator_4_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=26792844-1b2c-400d-8514-42d58028e5e5
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3526719.git" capsule-repo
	else
		git -c credential.helper= clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3526719.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-generic-quality-control-evaluation-aggregator
process capsule_aind_generic_quality_control_evaluation_aggregator_4 {
	tag 'capsule-5290719'
	container "$REGISTRY_HOST/published/03b3acfd-fdef-46b0-ad80-50e9d4e00827:v1"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/alignment-qc'
	path 'capsule/data/'
	path 'capsule/data/dff-qc'
	path 'capsule/data/'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=03b3acfd-fdef-46b0-ad80-50e9d4e00827
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5290719.git" capsule-repo
	else
		git -c credential.helper= clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5290719.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

params.fiber_raw_data_url = 's3://aind-open-data/behavior_821786_2026-02-23_14-13-33'

workflow {
	// input data
	fiber_raw_data_to_aind_fip_qc_raw_1 = Channel.fromPath(params.fiber_raw_data_url + "/", type: 'any')
	fiber_raw_data_to_aind_fip_nwb_base_standalone_2 = Channel.fromPath(params.fiber_raw_data_url + "/", type: 'any')
	fiber_raw_data_to_aind_fip_dff_3 = Channel.fromPath(params.fiber_raw_data_url + "/", type: 'any')

	// run processes
	capsule_aind_fip_nwb_base_standalone_2(fiber_raw_data_to_aind_fip_nwb_base_standalone_2.collect())
	capsule_aind_fip_qc_raw_1(fiber_raw_data_to_aind_fip_qc_raw_1.collect())
	capsule_aind_fip_dff_3(fiber_raw_data_to_aind_fip_dff_3.collect(), capsule_aind_fip_nwb_base_standalone_2.out.to_capsule_aind_fip_dff_3_4.collect())
	capsule_aind_generic_quality_control_evaluation_aggregator_4(capsule_aind_fip_nwb_base_standalone_2.out.to_capsule_aind_generic_quality_control_evaluation_aggregator_4_5, capsule_aind_fip_dff_3.out.to_capsule_aind_generic_quality_control_evaluation_aggregator_4_6.collect(), capsule_aind_fip_dff_3.out.to_capsule_aind_generic_quality_control_evaluation_aggregator_4_7, capsule_aind_fip_qc_raw_1.out.to_capsule_aind_generic_quality_control_evaluation_aggregator_4_8.collect())
}
