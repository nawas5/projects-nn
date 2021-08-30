import plotly.express as px
from skimage import io
data = io.imread("https://github.com/scikit-image/skimage-tutorials/raw/main/images/cells.tif")
img = data[20:45:2]
fig = px.imshow(img, facet_col=0, binary_string=True, facet_col_wrap=5)
fig.show()