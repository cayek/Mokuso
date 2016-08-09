.PHONY: mokuso_servr

mokuso_servr:
	R -e \
  'servr::jekyll(ifelse(!is.null(getOption("Mokusu.jekyll.dir")), getOption("Mokusu.jekyll.dir"),"."), port = 4000)'
