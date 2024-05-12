# Mothur analysis project outline

## Software dependencies

* `sickle` v1.33 (fastq trimming)
* `mothur` v1.48.0 (1.48.0 changes input/output and some commmand interfaces; the new pipeline is in-detail not compatible with previous versions)
* `python` and `matplotlib` (for plotting)

## Directories and files

<pre><font color="#5555FF"><b>.</b></font>
├── <font color="#5555FF"><b>analysis_script</b></font>
├── <font color="#55FFFF"><b>mothur.input.fastq</b></font> -&gt; <font color="#5555FF"><b>reads_qc</b></font>
├── mothur.input.list
├── <font color="#5555FF"><b>mothur.output</b></font>
├── <font color="#5555FF"><b>reads</b></font>
├── <font color="#5555FF"><b>reads_qc</b></font>
├── <font color="#5555FF"><b>ref_db</b></font>
├── samples.list
└── <font color="#5555FF"><b>script</b></font>
    ├── abundance_analysis.sh
    ├── <font color="#55FF55"><b>bs_resolve_sample_name.py</b></font>
    ├── clean_up.sh
    ├── <font color="#55FF55"><b>make_mothur_input.sh</b></font>
    ├── <font color="#55FF55"><b>make_mothur_silver_reference_files.py</b></font>
    ├── mothur.script.s1
    ├── mothur.script.s2
    ├── mothur.script.s3
    ├── pack_output.lite.sh
    ├── pack_output.sh
    ├── <font color="#55FF55"><b>preprocess.sh</b></font>
    └── <font color="#55FF55"><b>recruit_tax_from_truncated_align_fasta.py</b></font>
</pre>

Where:

* `reads/`: directory of raw fastq files
* `reads_qc/`: directory of QC'd fastq files
* `mothur.input.fastq`: `mothur`'s input reads directory, as a symlink to `reads_qc/` if no other preprocessing steps are necessay after QC.
* `mothur.input.list`: file used as `mothur` input
* `mothur.output/`: `mothur` output directory
* `ref_db/`: directory of reference database
* `script/`: directory of scripts

## Quick example

### 1. Analysis directory prepare

The analysis directory can be downloaded from online repo [https://github.com/ZJLEOWANG3/Amplicon_Sequencing_Analysis.git](https://github.com/ZJLEOWANG3/Amplicon_Sequencing_Analysis.git). You can download the repo from the above github page and unzip it, or run:

```bash
# this is the preferred way than download + unzip
git clone --recurse-submodules git@github.com:lguangyu/Amplicon_Sequencing_Analysis.git
```

The `analysis_script` folder contains necessary scripts to run downstream analysis, so make sure it's not empty if those analyses are planned. If empty, stuff it with another git call:

```bash
git submodule update --init --remote --recursive
```

### 2. Database prepare

You'll need at least three files:

* alignment reference: an aligned fasta file
* classification reference: fasta file
* mothur-compatible taxonomy file: should be paired with the classification reference fasta

Once prepared, put these three files into `ref_db/`, for example:

<pre><font color="#5555FF"><b>./ref_db</b></font>
├── silva.seed_v132.align
├── silva.nr_v138_1.align
└── silva.nr_v138_1.tax
</pre>

You can get some `mothur`-prepared dabase files from [https://mothur.org/wiki/silva_reference_files/](https://mothur.org/wiki/silva_reference_files/), or create your own.

```bash
wget $link-Full-length sequences and taxonomy references
tar -xzf $filename
```

### 3. Reads prepare

Decompress the reads into `reads/`, for example:

<pre><font color="#5555FF"><b>./reads</b></font>
├── SAMPLE1_R1.fastq
├── SAMPLE1_R2.fastq
├── SAMPLE2_R1.fastq
└── SAMPLE2_R2.fastq
</pre>

### 4. Enumerate samples

Enumerate the sample names in `samples.list`, can be created by any text editor:

```bash
$ cat samples.list
SAMPLE_1
SAMPLE_2
```

### 5. Preprocess

```bash
bash script/preprocess.sh
```

This script will call `sickle` do run QC, and output results in `reads_qc/`.

### 6. Make mothur input file

```bash
$ bash script/make_mothur_input.sh
```

This script fills the `mothur.input.list` text file. In the newer versions of `mothur` the same functionality can be achieved by the built-in command `make.file` (I haven't tried yet). It's a 3-column table with tab delimiter, in the example, may look like something below:

```
SAMPLE_1	mothur.input.fasta/SAMPLE_1_R1.fasta	mothur.input.fasta/SAMPLE_1_R2.fasta
SAMPLE_2	mothur.input.fasta/SAMPLE_2_R1.fasta	mothur.input.fasta/SAMPLE_2_R2.fasta
```

### 7. Run analysis stage 1

Stage 1 targets:

* contig assembly
* contig filter by length
* combine unique contig sequences

First check and edit file `script/mothur.script.s1`, particularly line 14. The minlength and maxlength need to be adjusted according to the amplified region. The example range 225-275 is determined from the length of the V4 region (~254bp) commonly used by our group. Then, run the script with `mothur`:

```bash
/home/a.onnis-hayden/opt/mothur/1.48.0/bin/mothur script/mothur.script.s1 > s1.output
```

### 8. Run analysis stage 2

Stage 2 targets:

* alignment to reference database

First check and edit file `script/mothur.script.s2`, particularly line 15. The `template` argument needs to be changed according to the alignment database used. Then, run the the script with `mothur`:

```bash
/home/a.onnis-hayden/opt/mothur/1.48.0/bin/mothur script/mothur.script.s2 > s2.output
```

### 9. Run analysis stage 3

Stage 3 targets:

* filter by alignment coordinates
* precluster (sequence denoising)
* chimera discover and removal
* taxonomy classification
* OTU making
* ASV making

First check and edit file `script/mothur.script.s3`, particularly line 14 and ling 42. In line 14, the filtering coordinates should be adjusted according to the last `summary.seqs()` results in the stage 2 log (`mothur.output/s2.mothur.log`). The example values `start=13870, end=23440` are subject to change under different region, primer, database, or parameters in previous steps. In line 42, the database parameters `reference` and `taxonomy` must be correctly configured. Then, run the script with `mothur`:

```bash
/home/a.onnis-hayden/opt/mothur/1.48.0/bin/mothur script/mothur.script.s3
```

The files with `final` prefix in the output directory `mothur.output` are final output files produced by `mothur` SOP.

### 10. Abundance fast analysis and plot

To plot a series of abudnance stats across samples, run:

```bash
$ bash script/abundance_analysis.sh
```

This script invokes python scripts in `analysis_script`, so make sure that `analysis_script` is not empty, in addition `python` and its plotting library `matplotlib` are available. The results will be stored in a new directory `abundance`.

### 11. Archive the results

There are two ways to pack and archive the results:

```bash
$ bash script/pack_output.lite.sh
```

will pack only those essential bits (e.g. `mothur.output/final*` and logs) for downstream analysis. In most cases they are sufficient. Alternatively,

```bash
$ bash script/pack_output.sh
```

will pack everything produced in `mothur.output` including those intermediate results. This can occasionally be useful when running a partially different analysis pipleline from a intermediate state, or for in-depth debugging/analysis purposes.

The abundance analysis results under `abundance` need addition effort to pack and archive, which is not included in `script/pack_output.sh` or `scipt/pack_output.lite.sh`.
