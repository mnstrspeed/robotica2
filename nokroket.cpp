#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

using namespace std;


#define VALUE_TRESHOLD 10
#define LENGTH_TRESHOLD 1


void find_edges(unsigned short edges[], unsigned short& num_edges,
	unsigned short values[], unsigned short num_values)
{
	num_edges = 0;
	edges[num_edges++] = 0;

	unsigned short i;
	for (i = 1; i < num_values; i++)
	{
		if (abs(values[i] - values[i - 1]) > VALUE_TRESHOLD)
		{
			if (i - edges[num_edges - 1] > LENGTH_TRESHOLD)
			{
				edges[num_edges++] = i;
			}
			else
			{
				num_edges--;
			}
		}
	}
	edges[num_edges++] = i;
}


void calibrate_sonar_fov(float &fov,
	float range, unsigned short num_measurements, // in real world
	float object_distance, float object_width, // in real world
	unsigned short object_begin, unsigned short object_end)
{
	float angle_interval = range / num_measurements;

	float detected_begin_angle = object_begin * angle_interval;
	float detected_end_angle = (object_end + 1) * angle_interval;
	float detected_alpha = detected_end_angle - detected_begin_angle;

	float actual_alpha = atan(object_width / 2 / object_distance);
	fov = detected_alpha - actual_alpha;
}

void compute_geometry(float& width, float& angle, float& begin_angle, float& end_angle,
	float detected_begin_angle, float detected_end_angle, float distance, float fov)
{
	begin_angle = detected_begin_angle + (fov / 2.0);
	end_angle = detected_end_angle - (fov / 2.0);

	float detected_angle = detected_end_angle - detected_begin_angle;
	angle = detected_angle - fov;
	width = tan(angle / 2.0 * M_PI / 180.0) * distance;
}

int main()
{
    //unsigned short values[] = { 255, 255, 46, 43, 42, 41, 41, 41, 42, 43, 255, 255, 255, 255, 255 };
    unsigned short values[] = { 255,255,255,255,255,255,255,27,26,
24,23,23,27,24,24,24,25 };
    unsigned short num_values = sizeof(values) / sizeof(unsigned short);

    unsigned short edges[128] = { 0 };
    unsigned short num_edges = 0;

    find_edges(edges, num_edges, values, num_values);

    cout << "num edges: " << num_edges << endl;
    unsigned short i;
    for (i = 0; i < num_edges; i++)
    {
        cout << edges[i] << endl;
    }

    /*
    float fov;
    calibrate_sonar_fov(fov,
        180, num_values,
        40, 5,
        edges[1], edges[2]);

    cout << "calibrated fov: " << fov << endl;
    */

    float width, angle, begin_angle, end_angle;
    compute_geometry(
        width, angle, begin_angle, end_angle,
        180 / num_values * edges[1], 180 / num_values * edges[2],
        41, 85);

    cout << "width: " << width << endl;
    cout << "angle: " << angle << endl;
    cout << "begin_angle: " << begin_angle << endl;
    cout << "end angle: " << end_angle << endl;


    return 0;
}

