Extension { #name : #GtSearchFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter class >> filterDescriptor2For: aMethodsCoder [
	^ self globalFilterDescriptor2
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter >> filterDescriptor2For: aMethodsCoder [
	^ self class filterDescriptor2For: aMethodsCoder
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter class >> filterDescriptorFor: aMethodsCoder [
	^ self globalFilterDescriptor
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter >> filterDescriptorFor: aMethodsCoder [
	^ self class filterDescriptorFor: aMethodsCoder
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter class >> globalFilterDescriptor [
	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter class >> globalFilterDescriptor2 [
	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchFilter class >> globalFilterDescriptors [
	| descriptors filters subclassDescriptors |
	descriptors := OrderedCollection new.
	filters := GtSearchFilter allSearchFilters
			asSortedCollection: [ :a :b | a filterLabel < b filterLabel ].
	filters
		do: [ :each | 
			| descriptor |
			descriptor := GtFilterDescriptor new
					valueNotRequired;
					creator: [ :value | each ];
					named: each filterLabel;
					order: descriptors size / filters size.
			each = GtSearchImageMethodsFilter forAllMethods
				ifFalse: [ descriptor beNotDefault ].
			descriptors add: descriptor ].
	subclassDescriptors := ((self withAllSubclasses
			collect: #globalFilterDescriptor) select: #notNil)
			asSortedCollection: [ :a :b | a order < b order ].
	subclassDescriptors do: #beNotDefault.
	descriptors addAll: subclassDescriptors.
	^ descriptors
]
