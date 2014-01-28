# pragma once

# include <thrust/device_vector.h>
# include <thrust/iterator/counting_iterator.h>
# include <thrust/iterator/zip_iterator.h>
# include <thrust/tuple.h>
# include <tiled.h>

template <class Type>
class Stencil7Pt{
public:
    typedef typename thrust::device_vector <Type>::iterator Iterator;
    typedef typename thrust::tuple <Iterator, Iterator>     Tuple;
    typedef typename thrust::zip_iterator<Tuple>            Zip;
    typedef typename thrust::tuple <Iterator, 
                           Zip, 
                           Zip,
                           Zip, 
                           thrust::counting_iterator<int> > Stencil7PtTuple;

    typedef typename thrust::zip_iterator<Stencil7PtTuple>  iterator;
};

typedef Stencil7Pt<double>::iterator FDStencilIterator;
