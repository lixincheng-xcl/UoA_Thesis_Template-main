# .latexmkrc — Overleaf build configuration for UoA Thesis
# Place this file in the root of your Overleaf project
# It tells Overleaf's latexmk how to compile your thesis

# Use XeLaTeX (required for Times New Roman via fontspec)
$pdf_mode = 5;

# Clean up intermediate files
$clean_ext .= ' %R.lof %R.lot %R.toc';
