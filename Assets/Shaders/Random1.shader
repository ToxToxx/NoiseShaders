Shader "Learning/Random1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RandomMultiplier("Random Multiplier", Range(1,100000)) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct VertexData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _RandomMultiplier;

            v2f vert (VertexData v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float random(float x, float m)
            {
                return frac(sin(x) * m);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float rnd = random(i.uv.x, _RandomMultiplier);
                return fixed4(rnd, rnd, rnd, 1);
            }
            ENDCG
        }
    }
}
