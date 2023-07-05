Class {
	#name : #GtIndexReferencesSizeDistribution,
	#superclass : #Object,
	#instVars : [
		'sizesWithCount'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtIndexReferencesSizeDistribution >> comparisonIntervals [
	| intervals currentLimit lastKey step |
	intervals := OrderedCollection new.
	currentLimit :=1.

	lastKey := sizesWithCount keys max.
	step := (lastKey /15) asInteger. 
	"step numberOfDigits."
	[currentLimit + step <= lastKey ] whileTrue: [
		intervals add: (currentLimit  ->  (currentLimit + step - 1 )).
		currentLimit := currentLimit + step ] .
	intervals add: (currentLimit -> (currentLimit + step)).
	
	^ intervals.
]

{ #category : #accessing }
GtIndexReferencesSizeDistribution >> gtViewLargest50SizesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Largest 50 sizes';
		priority: 10;
		items: [ (self sizesWithCount 
			associations  last: 50) reversed ];
		column: 'Size' text: [ :assoc | assoc key ];
		column: 'Number of collections' text: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtIndexReferencesSizeDistribution >> gtViewSizeIntervalsFor: aView [ 
	<gtView>
	
	^ aView columnedList
		title: 'Size Distribution';
		items: [ self splitByIntervals associations ];
		column: 'Sizes' text: [ :assoc | assoc key ];
		column: 'Number of collections' text: [ :assoc | assoc value 
			sumNumbers: [ :each | each value ] ];
		send: [ :assoc | self class new 
			sizesWithCount: assoc value asDictionary ]
]

{ #category : #accessing }
GtIndexReferencesSizeDistribution >> gtViewSmallest50SizesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Smallest 50 sizes';
		priority: 20;
		items: [ (self sizesWithCount  
			associations first: 50) ];
		column: 'Size' text: [ :assoc | assoc key ];
		column: 'Number of collections' text: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtIndexReferencesSizeDistribution >> sizesWithCount [
	^ sizesWithCount
]

{ #category : #accessing }
GtIndexReferencesSizeDistribution >> sizesWithCount: aDictionary [
	sizesWithCount := (aDictionary associations 
		sorted: [ :assoc | assoc key ] ascending)
			asOrderedDictionary
]

{ #category : #accessing }
GtIndexReferencesSizeDistribution >> splitByIntervals [
	^ self comparisonIntervals collect: [ :eachInterval |
		eachInterval -> (sizesWithCount associations select: [ :assoc |
			assoc key 
				between: eachInterval key  
				and: eachInterval value])
		] as: OrderedDictionary
]
