import numpy as np
import plotly.graph_objects as go


def plot_rooms(rooms, pointsIn, pointsOut):
    rooms_plot = rooms.copy()
    rooms_plot.append(rooms_plot[0])
    xr, yr = zip(*rooms_plot)

    xin, yin = pointsIn[:, 0], pointsIn[:, 1]
    xout, yout = pointsOut[:, 0], pointsOut[:, 1]

    fig = go.Figure()
    fig.add_trace(go.Scatter(x=xr, y=yr,
                             mode='lines',
                             name='path'))
    fig.add_trace(go.Scatter(x=xin, y=yin,
                             mode='markers',
                             name='points in path'))
    fig.add_trace(go.Scatter(x=xout, y=yout,
                             mode='markers', name='points out path'))

    fig.show()


def plot_mayak(coord_mayak, rooms):
    rooms_plot = rooms.copy()
    rooms_plot.append(rooms_plot[0])
    xr, yr = zip(*rooms_plot)

    fig = go.Figure()
    fig.add_trace(go.Scatter(x=xr, y=yr,
                             mode='lines',
                             name='path'))
    fig.add_trace(go.Scatter(x=coord_mayak[:, 0], y=coord_mayak[:, 1],
                             mode='markers',
                             name='coord mayak'))

    fig.show()


def plot_dop_factor(rooms, coord_mayak, DOP, pointsIndoor):
    rooms_plot = rooms.copy()
    rooms_plot.append(rooms_plot[0])
    xr, yr = zip(*rooms_plot)

    fig = go.Figure()
    fig.add_trace(go.Scatter3d(x=xr, y=yr, z=np.zeros(len(xr)),
                               mode='markers'))

    fig.add_trace(go.Mesh3d(x=(pointsIndoor[:, 0]),
                            y=(pointsIndoor[:, 1]),
                            z=(-DOP),
                            opacity=0.5,
                            color='pink'
                            ))

    fig.add_trace(go.Scatter3d(x=(pointsIndoor[:, 0]),
                               y=(pointsIndoor[:, 1]),
                               z=(-DOP),
                               mode="markers"
                               ))
    fig.show()
