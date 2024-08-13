##################################################
# Clientset                                      #
##################################################
# Kubebuilder project layout has API under 'api/v1'
# client-go codegen expects group name (wing) in the path ie. 'api/wing/v1'
# Because there's no way how to modify any of these settings,
# we need to hack things a little bit (use tmp directory 'api/wing/v1' and replace the name of package)
.PHONY: clientset-prepare
clientset-prepare:
	go mod vendor
	rm -rf api/wing
	mkdir api/wing
	cp -r api/v1 api/wing/v1

.PHONY: clientset-verify
clientset-verify: clientset-prepare
	./hack/verify-codegen.sh
	rm -rf api/wing
	rm -rf vendor

.PHONY: clientset-generate
clientset-generate: clientset-prepare
	./hack/update-codegen.sh
	rm -rf api/wing
	rm -rf vendor
