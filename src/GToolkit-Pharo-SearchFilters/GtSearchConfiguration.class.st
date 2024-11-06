Class {
	#name : #GtSearchConfiguration,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #'api - configuration' }
GtSearchConfiguration class >> defaultFutureExecutionConfiguration [
	^ AsyncFutureExecutionConfiguration new
		defaultPriority;
		customGroup: #Filters
]
