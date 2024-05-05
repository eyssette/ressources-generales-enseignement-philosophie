find . -name "*.md" -type f -print0 | while IFS= read -r -d $'\0' file; do \
  outdir=".public/$(dirname "${file}")"
  outfile="${outdir}/$(basename "${file}" .md).html"
  mkdir -p "${outdir}"
  pandoc -f markdown+mark+lists_without_preceding_blankline+emoji -t html -s "${file}" -o "${outfile}" --lua-filter=pandoc/fr-nbsp.lua --lua-filter=pandoc/set-title-from-h1.lua --lua-filter=pandoc/underline.lua --mathjax -c "${CI_PAGES_URL}/style.css" --template=pandoc/template.html --lua-filter=pandoc/include.lua
done
