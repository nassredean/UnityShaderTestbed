float _cucube(float3 p, float3 s, float3 th)
{
    float3 l = abs(p)-s;
    float cube = max(max(l.x, l.y), l.z);
    l = abs(l)-th;
    float x = max(l.y, l.z);
    float y = max(l.x, l.z);
    float z = max(l.x, l.y);
    
    return max(min(min(x, y), z), cube);
}

void Trace_half(float3 ro, float3 rd, float3 dim, int steps, out float3 output)
{
    float3 p = ro;
    for (int i = 0; i < 64; ++i)
    {
				float cucube = _cucube(
					p,
					5.*dim, // dimension ratio
					float3(.0001, .0001, .0001) // thickness of wire outline
				);
        if (cucube < 0.01) {
						float d = distance(p, ro);
            output = float3(d, d, d);
				}
        p+= rd*cucube;
    }
}
