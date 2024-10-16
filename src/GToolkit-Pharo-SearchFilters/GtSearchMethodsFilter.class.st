Class {
	#name : #GtSearchMethodsFilter,
	#superclass : #GtSearchTypedEntitiesFilter,
	#instVars : [
		'requesterContext'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchMethodsFilter class >> createFilterFor: aMethodCoder [
	^ self new
]

{ #category : #accessing }
GtSearchMethodsFilter class >> filterDescriptors2For: aMethodsCoder into: aCollection [
	(self filterDescriptor2For: aMethodsCoder) 
		ifNotNil: [ :aDescriptor | aCollection add: aDescriptor ]
]

{ #category : #accessing }
GtSearchMethodsFilter class >> filterDescriptorsFor: aMethodsCoder into: aCollection [
	(self filterDescriptorFor: aMethodsCoder) 
		ifNotNil: [ :aDescriptor | aCollection add: aDescriptor ]
]

{ #category : #accessing }
GtSearchMethodsFilter class >> resultType [
	^ GtAsyncSearchMethodGroupStream
]

{ #category : #accessing }
GtSearchMethodsFilter >> defaultFilterScope [
	^ AsyncImageMethodsStream new
]

{ #category : #testing }
GtSearchMethodsFilter >> includesMethod: aCompiledMethod [
	self subclassResponsibility
]

{ #category : #testing }
GtSearchMethodsFilter >> matches: anObject [
	^ anObject isCompiledMethod
		and: [ (self shouldFilterOutTraitMethods not or: [ anObject isFromTrait not ])
				and: [ self includesMethod: anObject ] ]
]

{ #category : #accessing }
GtSearchMethodsFilter >> requesterContext [
	<return: #GtSearchMethodCoderFilterContext or: nil>
	^ requesterContext
]

{ #category : #accessing }
GtSearchMethodsFilter >> requesterContext: anObject [
	requesterContext := anObject
]

{ #category : #'api - accessing' }
GtSearchMethodsFilter >> requesterContextDo: aBlock [
	"Pass a requester context to aBlock if the  context is available"

	^ self requesterContext ifNotNil: aBlock
]

{ #category : #accessing }
GtSearchMethodsFilter >> shouldFilterOutTraitMethods [
	^ false
]
