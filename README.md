# GitOps Agent Helm Chart

A helm chart for the Harness GitOps Agent.

## To Install

Copy the `values-override.yaml` file, and fill in the respective fields from an agent created in your Harness account.  

Then run the following command `helm install -n <target-namespace> gitops-agent . -f values-override.yaml`

### Multiple Agents in Single Cluster

When using multiple agents across the same kubernetes cluster, only one chart should control the installation of the Argo CustomResourceDefinitions used for Harness GitOps.  Subsequent agent installs can disable the installtion of the CRDs by setting `argocd.manageCRDs` to `false`

### Considerations for a Self Managed Platform Install

Agent installations connecting to Self Managed Platform (SMP) Harness installs should make sure to set the following fields.  

* `harness.smpManagerURL` - The URL you use to log into Harness (e.g. https://harness.company.net)
* `harness.certBundle` - Certificates to trust for connectivity from the agent.  Should contain the list of endpoint certificates that need trusted from the agent, such as the SMP host and git repository servers.